import { Route, BrowserRouter, Routes } from 'react-router-dom';
import Home from './pages/HomePage.js';
import Edit from './pages/EditPage.js'
import Add from './pages/AddPage.js';
import AppNavbar from './components/AppNavbar.js';

function App() 
{
  return (
    <BrowserRouter>
      <AppNavbar/>
      <Routes>
        <Route path='/' element={<Home/>}/>
        <Route path='/add' element={<Add/>}/>
        <Route path='/edit' element={<Edit/>}/>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
