import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import axios from 'axios'
import './Login.css'
export function Login() {
    const [usuario, setUsuario] = useState('')
    const [senha, setSenha] = useState('')
    const navigate = useNavigate()
    const goTo = (location) => {
        return navigate(location)
    }
    const changeUsuario = (e) => {
        setUsuario(e.target.value)
    }
    const changeSenha = (e) => {
        setSenha(e.target.value)
    }
    const login = () => {
        axios
            .post('http://localhost:8080/caixa/login', {
                login: usuario,
                senha: senha,
                nome: '',
                telefone: '',
                cpf: '',
            })
            .then((reponse) => {
                console.log(reponse.data)
                if (reponse.data === 'ok') {
                    return goTo('/fecharPedido')
                } else {
                    alert('usuário ou senha incorretos')
                }
            })
    }
    return (
        <>
            <div className="adminForm">
                <h3>Login Caixa Big Burguer</h3>
                <label htmlFor="usuario">Usuário</label>
                <input type="text" value={usuario} onChange={changeUsuario} />
                <label htmlFor="senha">Senha</label>
                <input type="text" value={senha} onChange={changeSenha} />
                <button
                    onClick={() => {
                        login()
                    }}
                >
                    Login
                </button>
            </div>
        </>
    )
}
