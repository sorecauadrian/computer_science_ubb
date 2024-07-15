import { Route, BrowserRouter, Routes } from 'react-router-dom';
import Home from './pages/HomePage.js';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path='/' element={<Home />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
