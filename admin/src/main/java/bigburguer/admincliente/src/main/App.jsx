import './App.css'
import Routes from './Routes'
import React from 'react'
import { BrowserRouter } from 'react-router-dom'

function App() {
    return (
        <BrowserRouter basename={process.env.PUBLIC_URL}>
            <div className="app">
                <Routes />
            </div>
        </BrowserRouter>
    )
}

export default App
