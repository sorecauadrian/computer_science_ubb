#include <bits/stdc++.h>
#include <chrono>
#include <mpi.h>

using namespace std;

vector<int> get_random_poly(size_t degree) {
  random_device rd;
  mt19937 gen(rd());

  vector<int> answer(degree + 1, 0);

  for(auto &it: answer) {
    it = gen() & 0xff;
  }

  return answer;
}

int compute_coef(const vector<int>& p1, const vector<int> &p2, size_t coef) {
  int answer = 0;
  for(size_t i = (size_t)max(0, ((int)coef) - ((int)p2.size() - 1)); i <= min(coef, p1.size() - 1); i++) {
      answer += p1[i] * p2[coef - i];
  }
  return answer;
}

//works with [start, end)
void worker_naive() {
  int p1_size;
  int p2_size;

  MPI_Recv(&p1_size, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  MPI_Recv(&p2_size, 1, MPI_INT, 0, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  vector<int> p1((size_t)p1_size);
  vector<int> p2((size_t)p2_size);

  MPI_Recv(p1.data(), p1_size, MPI_INT, 0, 3, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  MPI_Recv(p2.data(), p2_size, MPI_INT, 0, 4, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 

  int start, end;
  
  MPI_Recv(&start, 1, MPI_INT, 0, 5, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  MPI_Recv(&end, 1, MPI_INT, 0, 6, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
 
  vector<int> answer((size_t)(end - start));
  for(size_t i = 0; i < answer.size(); i++) {
    answer[i] = compute_coef(p1, p2, i + (size_t)start);
  }
  MPI_Ssend(answer.data(), (int)answer.size(), MPI_INT, 0, 1, MPI_COMM_WORLD);
}

vector<int> master_naive(int nrProcs, const vector<int>& p1, const vector<int> &p2) {
  if(p1.size() == 0 && p2.size() == 0) return {0};
  int answer_coefs = (int)p1.size() + (int)p2.size() - 1;
  int next_start = 0;
  int current_start = 0;
  int current_end = 0;
  vector<int> work_sizes;
  for(int i = 0; i < nrProcs; i++) {
    int next_end = next_start + (answer_coefs / nrProcs) + (i < (answer_coefs % nrProcs));
    if(i == 0) {
      current_start = next_start;
      current_end = next_end;
    } else {
      int tmp;
      tmp = (int)p1.size();
      MPI_Ssend(&tmp, 1, MPI_INT, i, 1, MPI_COMM_WORLD);
      tmp = (int)p2.size();
      MPI_Ssend(&tmp, 1, MPI_INT, i, 2, MPI_COMM_WORLD);
      MPI_Ssend(p1.data(), (int)p1.size(), MPI_INT, i, 3, MPI_COMM_WORLD);
      MPI_Ssend(p2.data(), (int)p2.size(), MPI_INT, i, 4, MPI_COMM_WORLD);
      tmp = next_start;
      MPI_Ssend(&tmp, 1, MPI_INT, i, 5, MPI_COMM_WORLD);
      tmp = next_end;
      MPI_Ssend(&tmp, 1, MPI_INT, i, 6, MPI_COMM_WORLD);
    }
    work_sizes.push_back(next_end - next_start);
    next_start = next_end;
  }
 
  vector<int> answer((size_t)answer_coefs, 0);

  for(size_t i = (size_t)current_start; i < (size_t)current_end; i++) {
    answer[i] = compute_coef(p1, p2, i);
  }

  int current_offset = work_sizes[0];
  for(int i = 1; i < nrProcs; i++) {
    MPI_Recv(answer.data() + current_offset, work_sizes[(size_t)i], MPI_INT, i, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
    current_offset += work_sizes[(size_t)i];
  }

  return answer;
}

void freeSubWorkers(int process_id) {
  int tmp = 1;
  MPI_Ssend(&tmp, 1, MPI_INT, process_id, 1, MPI_COMM_WORLD);
  MPI_Ssend(&tmp, 1, MPI_INT, process_id, 2, MPI_COMM_WORLD);
  MPI_Ssend(&tmp, 1, MPI_INT, process_id, 3, MPI_COMM_WORLD);
  MPI_Ssend(&tmp, 1, MPI_INT, process_id, 4, MPI_COMM_WORLD);
  MPI_Ssend(&tmp, 1, MPI_INT, process_id, 5, MPI_COMM_WORLD);
  MPI_Ssend(&tmp, 1, MPI_INT, process_id, 6, MPI_COMM_WORLD);
  MPI_Recv(&tmp, 1, MPI_INT, process_id, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
  vector<int> v((size_t)tmp);
  MPI_Recv(v.data(), tmp, MPI_INT, process_id, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
}

// [child_begin, child_end)
vector<int> karatsuba_mult(const vector<int> &p1, const vector<int> &p2, int child_begin, int child_end) {
  if(p1.size() == 0 && p2.size() == 0) return {0};
  if(p1.size() + p2.size() <= 1024) {
    vector<int> answer(p1.size() + p2.size() - 1);

    for(size_t i = 0; i < answer.size(); i++) {
      answer[i] = compute_coef(p1, p2, i);
    }
    for(int i = child_begin; i < child_end; i++) {
      freeSubWorkers(i); 
    }
    return answer;
  }

  vector<int> low_p1; 
  vector<int> low_p2; 
  vector<int> high_p1; 
  vector<int> high_p2; 
  vector<int> p1_sum;
  vector<int> p2_sum;
  size_t n = (max(p1.size(), p2.size()) + 1) / 2;
  low_p1.reserve(n);
  high_p1.reserve(n * 2);
  low_p2.reserve(n);
  high_p2.reserve(n * 2);
  p1_sum.reserve(n * 2);
  p2_sum.reserve(n * 2);

  for(size_t i = 0; i < p1.size(); i++) {
    if(i < n) {
      low_p1.push_back(p1[i]);
    } else {
      high_p1.push_back(p1[i]);
    }
  }
  
  for(size_t i = 0; i < p2.size(); i++) {
    if(i < n) {
      low_p2.push_back(p2[i]);
    } else {
      high_p2.push_back(p2[i]);
    }
  }


  for(size_t i = 0; i < low_p1.size() || i < high_p1.size(); i++) {
    p1_sum.push_back(0);
    p1_sum[i] += (i < low_p1.size() ? low_p1[i]:0);
    p1_sum[i] += (i < high_p1.size() ? high_p1[i]:0);
  }
  for(size_t i = 0; i < low_p2.size() || i < high_p2.size(); i++) {
    p2_sum.push_back(0);
    p2_sum[i] += (i < low_p2.size() ? low_p2[i]:0);
    p2_sum[i] += (i < high_p2.size() ? high_p2[i]:0);
  }

  vector<int> low_part_mult;
  vector<int> high_part_mult;
  vector<int> sum_part_mult;

  int low_part_id = -1;
  int high_part_id = (child_begin < child_end ? child_begin++:-1);
  int sum_part_id = (child_begin < child_end ? child_begin++:-1);

  int low_part_end = (child_begin * 2 + child_end) / 3;
  int high_part_end = (child_begin + child_end * 2) / 3;

  if(low_part_id != -1) {
    int process_id = low_part_id;
    int tmp;

    tmp = (int)low_p1.size();
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 1, MPI_COMM_WORLD);
    MPI_Ssend(low_p1.data(), (int)low_p1.size(), MPI_INT, process_id, 2, MPI_COMM_WORLD);
    
    tmp = (int)low_p2.size();
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 3, MPI_COMM_WORLD);
    MPI_Ssend(low_p2.data(), (int)low_p2.size(), MPI_INT, process_id, 4, MPI_COMM_WORLD);
    
    tmp = child_begin;
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 5, MPI_COMM_WORLD);
    tmp = low_part_end;
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 6, MPI_COMM_WORLD);
  } 

  if(high_part_id != -1) {
    int process_id = high_part_id;
    int tmp;

    tmp = (int)high_p1.size();
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 1, MPI_COMM_WORLD);
    MPI_Ssend(high_p1.data(), (int)high_p1.size(), MPI_INT, process_id, 2, MPI_COMM_WORLD);
    
    tmp = (int)high_p2.size();
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 3, MPI_COMM_WORLD);
    MPI_Ssend(high_p2.data(), (int)high_p2.size(), MPI_INT, process_id, 4, MPI_COMM_WORLD);
    
    tmp = low_part_end;
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 5, MPI_COMM_WORLD);
    tmp = high_part_end;
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 6, MPI_COMM_WORLD);
  }
  
  if(sum_part_id != -1) {
    int process_id = sum_part_id;
    int tmp;

    tmp = (int)p1_sum.size();
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 1, MPI_COMM_WORLD);
    MPI_Ssend(p1_sum.data(), (int)p1_sum.size(), MPI_INT, process_id, 2, MPI_COMM_WORLD);
    
    tmp = (int)p2_sum.size();
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 3, MPI_COMM_WORLD);
    MPI_Ssend(p2_sum.data(), (int)p2_sum.size(), MPI_INT, process_id, 4, MPI_COMM_WORLD);
    
    tmp = high_part_end;
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 5, MPI_COMM_WORLD);
    tmp = child_end;
    MPI_Ssend(&tmp, 1, MPI_INT, process_id, 6, MPI_COMM_WORLD);
  }
  
  if(low_part_id == -1) {
    low_part_mult = karatsuba_mult(low_p1, low_p2, child_begin, low_part_end);
  }

  if(high_part_id == -1) {
    high_part_mult = karatsuba_mult(high_p1, high_p2, low_part_end, high_part_end);
  }

  if(sum_part_id == -1) {
    sum_part_mult = karatsuba_mult(p1_sum, p2_sum, high_part_end, child_end);
  }

  if(low_part_id != -1) {
    int length;
    MPI_Recv(&length, 1, MPI_INT, low_part_id, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
    low_part_mult = vector<int>((size_t)length);
    
    MPI_Recv(low_part_mult.data(), length, MPI_INT, low_part_id, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  }    
  if(high_part_id != -1) {
    int length;
    MPI_Recv(&length, 1, MPI_INT, high_part_id, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
    high_part_mult = vector<int>((size_t)length);
    MPI_Recv(high_part_mult.data(), length, MPI_INT, high_part_id, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  }
  
  if(sum_part_id != -1) {
    int length;
    MPI_Recv(&length, 1, MPI_INT, sum_part_id, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
    sum_part_mult = vector<int>((size_t)length);
    MPI_Recv(sum_part_mult.data(), length, MPI_INT, sum_part_id, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  }

  vector<int> answer(max(max(low_part_mult.size(), high_part_mult.size() + 2 * n), sum_part_mult.size() + n));
  for(size_t i = 0; i < low_part_mult.size(); i++) {
    answer[i] += low_part_mult[i];
  }
  
  for(size_t i = 0; i < high_part_mult.size(); i++) {
    answer[i + 2 * n] += high_part_mult[i];
  }

  for(size_t i = 0; i < low_part_mult.size() || i < high_part_mult.size() || i < sum_part_mult.size(); i++) {
    answer[i + n] += (i < sum_part_mult.size() ? sum_part_mult[i]:0);
    answer[i + n] -= (i < low_part_mult.size() ? low_part_mult[i]:0);
    answer[i + n] -= (i < high_part_mult.size() ? high_part_mult[i]:0);
  }

  return answer;
}

void worker_karatsuba() {
  int p1_length;
  MPI_Status status;
  MPI_Recv(&p1_length, 1, MPI_INT, MPI_ANY_SOURCE, 1, MPI_COMM_WORLD, &status); 
  vector<int> p1((size_t)p1_length);
  MPI_Recv(p1.data(), (int)p1.size(), MPI_INT, MPI_ANY_SOURCE, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  int p2_length;
  MPI_Recv(&p2_length, 1, MPI_INT, MPI_ANY_SOURCE, 3, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  vector<int> p2((size_t)p2_length);
  MPI_Recv(p2.data(), (int)p2.size(), MPI_INT, MPI_ANY_SOURCE, 4, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  int child_begin, child_end;
  MPI_Recv(&child_begin, 1, MPI_INT, MPI_ANY_SOURCE, 5, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 
  MPI_Recv(&child_end, 1, MPI_INT, MPI_ANY_SOURCE, 6, MPI_COMM_WORLD, MPI_STATUS_IGNORE); 

  vector<int> answer = karatsuba_mult(p1, p2, child_begin, child_end);
  int tmp = (int)answer.size();
  MPI_Ssend(&tmp, 1, MPI_INT, status.MPI_SOURCE, 1, MPI_COMM_WORLD);
  MPI_Ssend(answer.data(), (int)answer.size(), MPI_INT, status.MPI_SOURCE, 2, MPI_COMM_WORLD);
  
}

vector<int> master_karatsuba(int nrProcs, const vector<int> &p1, const vector<int> &p2) {
  return karatsuba_mult(p1, p2, 1, nrProcs);
}

int main(int argc, char** argv) {
  MPI_Init(0, 0);
  int me;
  int nrProcs;
  MPI_Comm_size(MPI_COMM_WORLD, &nrProcs);
  MPI_Comm_rank(MPI_COMM_WORLD, &me);

  if(argc != 4){
    cerr << "usage: mult METHOD P1_DEGREE P2_DEGREE\n";
    return 1;
  }


  bool naiveMethod = (strcmp(argv[1], "naive") == 0);
  if(me == 0) {
    int p1_degree = atoi(argv[2]);
    int p2_degree = atoi(argv[3]);
    
    vector<int> p1 = get_random_poly((size_t)p1_degree);
    vector<int> p2 = get_random_poly((size_t)p2_degree);
    
    cout << "Selected polys:" << "\n";
    for(auto it: p1) cout << it << " "; cout << "\n";
    for(auto it: p2) cout << it << " "; cout << "\n";

    auto start = std::chrono::high_resolution_clock::now();
    vector<int> answer;
    if(naiveMethod) {
      answer = master_naive(nrProcs, p1, p2);
    } else {
      answer = master_karatsuba(nrProcs, p1, p2);
    }
    auto end = std::chrono::high_resolution_clock::now();

    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);

    cout << "Result:" << "\n";
    cerr << "Duraction " << duration.count() << "ns\n";
    for(auto it: answer) cout << it << " "; cout << "\n";
  } else {
    if(naiveMethod) {
      worker_naive();
    } else {
      worker_karatsuba();
    }
  }

  MPI_Finalize();
}