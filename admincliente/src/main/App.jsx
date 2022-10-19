import './App.css'
import Routes from './Routes'
import React from 'react'
import { BrowserRouter } from 'react-router-dom'
import { Header } from '../components/Header'

function App() {
    return (
        <BrowserRouter basename={process.env.PUBLIC_URL}>
            <div className="app">
                <Header></Header>
                <Routes />
            </div>
        </BrowserRouter>
    )
}

export default App
