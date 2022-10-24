import React,{ useState } from 'react'
import { useNavigate } from 'react-router-dom'
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
    const login = ()=>{
        if(usuario === 'admin' && senha === 'admin'){
            return goTo('/pratos')
        }
        console.log(usuario, senha)
    }
    return (
        <>
            <form className="adminForm">
                <h3>Login Administração</h3>
                <label htmlFor="usuario">Usuário</label>
                <input type="text" value={usuario} onChange={changeUsuario} />
                <label htmlFor="senha">Senha</label>
                <input type="text" value={senha} onChange={changeSenha} />
                <button onClick={()=>{login()}}>Login</button>
            </form>
        </>
    )
}
