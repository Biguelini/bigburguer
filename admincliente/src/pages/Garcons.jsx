import React, { useEffect, useState } from 'react'
import './Garcons.css'
import axios from 'axios'

import { FaPlus } from 'react-icons/fa'
export function Garcons() {
    const [garcons, setGarcons] = useState([])
    const [isActive, setIsActive] = useState(false)
    const [nome, setNome] = useState('')
    const [login, setLogin] = useState('')
    const [senha, setSenha] = useState('')
    const [cpf, setCpf] = useState('')
    const [telefone, setTelefone] = useState('')
    const [cargo, setCargo] = useState('')
    const getGarcons = () => {
        axios
            .get('http://localhost:8080/admin/garcom')
            .then(function (response) {
                setGarcons(response.data)
            })
    }
    const postPratos = () => {
        axios
            .post('http://localhost:8080/admin/pratos', { nome })
            .then(function (response) {
                console.log(response)
                alert('Prato cadastrado')
                setNome('')
            })
            .catch(function (e) {
                alert('Preencha os dados corretamente')
                return console.log(e)
            })
    }
    const changeNome = (e) => {
        setNome(e.target.value)
    }
    const changeLogin = (e) => {
        setLogin(e.target.value)
    }
    const changeSenha = (e) => {
        setSenha(e.target.value)
    }
    const changeCpf = (e) => {
        setCpf(e.target.value)
    }
    const changeTelefone = (e) => {
        setTelefone(e.target.value)
    }
    const changeCargo = (e) => {
        setCargo(e.target.value)
    }
    const showForm = () => {
        setIsActive((current) => !current)
        if (isActive) {
            postPratos()
        }
    }
    useEffect(() => {
        getGarcons()
    }, [garcons])
    return (
        <>
            <table>
                <caption>Funcionários</caption>
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Login</th>
                        <th>Senha</th>
                        <th>CPF</th>
                        <th>Telefone</th>
                        <th>Cargo</th>
                    </tr>
                </thead>
                <tbody>
                    {garcons.map((garcon) => {
                        return (
                            <tr key={garcon.id}>
                                <td data-label="Nome">{garcon.nome}</td>
                                <td data-label="Login">{garcon.login}</td>
                                <td data-label="Senha">{garcon.senha}</td>
                                <td data-label="CPF">{garcon.cpf}</td>
                                <td data-label="Telefone">{garcon.telefone}</td>
                                <td data-label="Cargo">{garcon.cargo}</td>
                            </tr>
                        )
                    })}
                </tbody>
            </table>
            <form className={isActive ? 'formFuncionario active' : 'formFuncionario'}>
                <h3>Adicionar Funcionário</h3>
                <div>
                    <label htmlFor="nome">Nome</label>
                    <input type="text" value={nome} onChange={changeNome} />
                </div>
                <div>
                    <label htmlFor="nome">Login</label>
                    <input type="text" value={login} onChange={changeLogin} />
                </div>
                <div>
                    <label htmlFor="nome">Senha</label>
                    <input type="text" value={senha} onChange={changeSenha} />
                </div>
                <div>
                    <label htmlFor="nome">CPF</label>
                    <input type="text" value={cpf} onChange={changeCpf} />
                </div>
                <div>
                    <label htmlFor="nome">Telefone</label>
                    <input type="text" value={telefone} onChange={changeTelefone} />
                </div>
                <div>
                    <label htmlFor="nome">Cargo</label>
                    <input type="text" value={cargo} onChange={changeCargo} />
                </div>
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
