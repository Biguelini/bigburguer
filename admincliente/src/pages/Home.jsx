import React, { useEffect, useState } from 'react'
import './Home.css'
import axios from 'axios'
export function Home() {
    const [pratos, setPratos] = useState([])
    const getPratos = () => {
        axios
            .get('http://localhost:8080/admin/pratos')
            .then(function (response) {
                setPratos(response.data)
            })
    }
    useEffect(() => {
        getPratos()
    }, [])
    return (
        <table>
            <caption>Pratos</caption>
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Nome</th>
                    <th>Preço</th>
                </tr>
            </thead>
            <tbody>
                {pratos.map((prato) => {
                    return (
                        <tr key={prato.id}>
                            <td data-label="Id">{prato.id}</td>
                            <td data-label="Nome">{prato.nome}</td>
                            <td data-label="Preço">{prato.preco}</td>
                        </tr>
                    )
                })}
            </tbody>
        </table>
    )
}
