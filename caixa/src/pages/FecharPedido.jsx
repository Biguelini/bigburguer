import axios from 'axios'
import React, { useEffect, useState } from 'react'
import './FecharPedido.css'
export function FecharPedido() {
    const [pedidoFechado, setPedidoFechado] = useState(false)
    const [valor, setValor] = useState(0)
    const fecharPedido = () => {
        setPedidoFechado(true)
        console.log(valor)
        axios
            .get('http://localhost:8080/admin/pedidos/')
            .then(function (response) {
                let dinheiro = 0
                const pedidos = response.data
                pedidos.map((pedido) => {
                    if (pedido.idMesa === 4) {
                        if (
                            pedido.status !== 'cancelado' &&
                            pedido.status !== 'pago'
                        ) {
                            dinheiro += 25
                        }
                    }
                    return ''
                })
                setValor(dinheiro)
            })
            .catch(function (error) {
                console.error(error)
            })
        setValor(20)
    }
    useEffect(() => {
        console.log(pedidoFechado)
    }, [pedidoFechado])
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
                    Fechar Pedido
                </button>
            </div>
            {pedidoFechado ? <p>Total: R$ {valor}</p> : <></>}
        </>
    )
}
