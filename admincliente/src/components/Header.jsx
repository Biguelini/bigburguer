import React from 'react'
import { useNavigate } from 'react-router-dom'
import './Header.css'
export function Header() {
    const navigate = useNavigate()
    const goTo = (location) => {
        return navigate(location)
    }
    return (
        <header>
            <h1>BigBurguer</h1>
            <nav>
                <ul>
                    <li onClick={()=>{goTo('/pratos')}}>Lanches</li>
                    <li onClick={()=>{goTo('/funcionarios')}}>Funcionários</li>
                    <li onClick={()=>{goTo('/pedidos')}}>Pedidos</li>
                </ul>
            </nav>
        </header>
    )
}
