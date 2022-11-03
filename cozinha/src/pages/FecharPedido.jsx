import React, { useEffect, useState } from 'react'
import './FecharPedido.css'
export function FecharPedido() {
    const [pedidoFechado, setPedidoFechado] = useState(false);
    const [valor, setValor] = useState(0);
    const fecharPedido = () => {
        setPedidoFechado(true)
        setValor(20)
    }
    useEffect(() => {
        console.log(pedidoFechado)
    }, [pedidoFechado]);
    return (
        <>
            <div className="adminForm">
                <h1>Fechar pedido</h1>
                <label htmlFor="usuario">Mesa</label>
                <input type="number" />
                <button
                    onClick={() => {
                        fecharPedido()
                    }}
                >
                    Login
                </button>
            </div>
            {pedidoFechado?<p>Total: R$ {valor}</p>:<></>}
        </>
    )
}
