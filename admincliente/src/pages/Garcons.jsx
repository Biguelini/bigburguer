import React, { useEffect, useState } from 'react'
import './Garcons.css'
import axios from 'axios'

import { FaPlus, FaTimes } from 'react-icons/fa'
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
            .post('http://localhost:8080/admin/garcom', {
                nome,
                login,
                senha,
                cpf,
                telefone,
                cargo,
            })
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
    const closeForm = () => {
        setIsActive((current) => !current)
    }
    useEffect(() => {
        getGarcons()
    }, [garcons])
    return (
        <>
            <table className="funcionarios">
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
                                <td data-label="Senha">
                                    {'•'.repeat(garcon.senha.length)}
                                </td>
                                <td data-label="CPF">{garcon.cpf}</td>
                                <td data-label="Telefone">{garcon.telefone}</td>
                                <td data-label="Cargo">{garcon.cargo}</td>
                            </tr>
                        )
                    })}
                </tbody>
            </table>
            <form
                className={
                    isActive ? 'formFuncionario active' : 'formFuncionario'
                }
            >
                <div className='title'>
                    <h3>Adicionar Funcionário</h3>
                    <FaTimes className='closeButtonForm' onClick={closeForm}/>
                </div>
                <div>
                    <label htmlFor="nome">Nome</label>
                    <input type="text" value={nome} onChange={changeNome} />
                </div>
                <div>
                    <label htmlFor="cargo">Cargo</label>
                    <select onChange={changeCargo}>
                        <option selected>Selecione</option>
                        <option value="caixa">Caixa</option>
                        <option value="cozinha">Cozinha</option>
                        <option value="garcom">Garçom</option>
                    </select>
                </div>
                <div>
                    <label htmlFor="login">Login</label>
                    <input type="text" value={login} onChange={changeLogin} />
                </div>
                <div>
                    <label htmlFor="senha">Senha</label>
                    <input
                        type="password"
                        value={senha}
                        onChange={changeSenha}
                    />
                </div>
                <div>
                    <label htmlFor="cpf">CPF</label>
                    <input type="text" value={cpf} onChange={changeCpf} />
                </div>
                <div>
                    <label htmlFor="telefone">Telefone</label>
                    <input
                        type="text"
                        value={telefone}
                        onChange={changeTelefone}
                    />
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
