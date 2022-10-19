import React from 'react'
import { Routes, Route } from 'react-router-dom'
import { Home } from '../pages/Home'
export default function RouteApps(props) {
    return (
        <Routes>
            <Route exact path="/" element={<Home />} />

            <Route path="*" element={<Home />} />
        </Routes>
    )
}