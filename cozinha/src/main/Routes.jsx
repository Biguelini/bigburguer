import React from 'react'
import { Routes, Route } from 'react-router-dom'
import { FecharPedido } from '../pages/FecharPedido'
import { Login } from '../pages/Login'
export default function RouteApps(props) {
    return (
        <Routes>
            <Route exact path="/fecharPedido" element={<FecharPedido />} />

            <Route path="*" element={<Login />} />
            <Route path="/" element={<Login />} />
        </Routes>
    )
}