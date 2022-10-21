import React from 'react'
import { Routes, Route } from 'react-router-dom'
import { Pratos } from '../pages/Pratos'
import { Login } from '../pages/Login'
import { Garcons } from '../pages/Garcons'
export default function RouteApps(props) {
    return (
        <Routes>
            <Route exact path="/pratos" element={<Pratos />} />
            <Route exact path="/funcionarios" element={<Garcons />} />

            <Route path="*" element={<Login />} />
            <Route path="/" element={<Login />} />
        </Routes>
    )
}