import React, { useEffect, useState } from 'react'
import './Pratos.css'
import axios from 'axios'

import { FaPlus, FaTrash,FaPen } from 'react-icons/fa'
export function Pratos() {
    const [pratos, setPratos] = useState([])
    const [isActive, setIsActive] = useState(false)
    const [nome, setNome] = useState('')
    const [preco, setPreco] = useState(0)
    const getPratos = () => {
        axios
            .get('http://localhost:8080/admin/pratos')
            .then(function (response) {
                setPratos(response.data)
            })
    }
    const postPratos = () => {
        axios
            .post('http://localhost:8080/admin/pratos', { nome, preco })
            .then(function (response) {
                console.log(response)
                alert('Prato cadastrado')
                setNome('')
                setPreco(0)
            })
            .catch(function (e) {
                alert('Preencha os dados corretamente')
                return console.log(e)
            })
    }
    const changeNome = (e) => {
        setNome(e.target.value)
    }
    const changePreco = (e) => {
        setPreco(e.target.value)
    }
    const showForm = () => {
        setIsActive((current) => !current)
        if (isActive) {
            postPratos()
        }
    }
    useEffect(() => {
        getPratos()
    }, [pratos])
    return (
        <>
            <table>
                <caption>Pratos</caption>
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Preço</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    {pratos.map((prato) => {
                        return (
                            <tr key={prato.id}>
                                <td data-label="Nome">{prato.nome}</td>
                                <td data-label="Preço">{prato.preco}</td>
                                <td data-label="Ações"><FaTrash/><FaPen/></td>
                            </tr>
                        )
                    })}
                </tbody>
            </table>
            <form className={isActive ? 'formPrato active' : 'formPrato'}>
                <h3>Adicionar Prato</h3>
                <label htmlFor="nome">Nome</label>
                <input type="text" value={nome} onChange={changeNome} />
                <label htmlFor="preco">Preço</label>
                <input
                    type="number"
                    step="0.01"
                    min="0"
                    value={preco}
                    onChange={changePreco}
                />
            </form>
            <button
                className={isActive ? 'addButton active' : 'addButton'}
                onClick={() => {
                    showForm()
                }}
            >
                {!isActive ? <FaPlus /> : 'Salvar'}
            </button>
        </>
    )
}
