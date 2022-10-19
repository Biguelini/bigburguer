import { Link } from 'react-router-dom'
import React from 'react'

export function Header() {
    return (
        <header>
            <h1>BigBurguer</h1>
            <nav>
                <ul>
                    <li><Link>Lanches</Link></li>
                    <li><Link>Garçons</Link></li>
                    <li><Link>Pedidos</Link></li>
                </ul>
            </nav>
        </header>
    )
}
