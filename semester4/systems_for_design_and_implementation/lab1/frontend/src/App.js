import { Route, BrowserRouter, Routes } from 'react-router-dom';
import './App.css';
import Home from './components/Home.js';
import Edit from './components/Edit.js'
import Add from './components/Add.js';

function App() {
  return (
    <>
        <BrowserRouter>
          <Routes>
            <Route path='/' element={<Home/>}/>
            <Route path='/add' element={<Add/>}/>
            <Route path='/edit' element={<Edit/>}/>
          </Routes>
        </BrowserRouter>
    </>
  );
}

export default App;
