import axios from 'axios'
import React, { useEffect, useState } from 'react'
import './FecharPedido.css'
export function FecharPedido() {
    const [pedidoFechado, setPedidoFechado] = useState(false)
    const [valor, setValor] = useState(0)
    const [mesa, setMesa] = useState(0)
    const fecharPedido = () => {
        setValor('Esta mesa não tem pedidos')
        setPedidoFechado(true)
        let dinheiro = 0
        axios
            .get('http://localhost:8080/admin/pedidos/')
            .then(function (response) {
                const pedidos = response.data
                pedidos.map((pedido) => {
                    if (pedido.idMesa === parseInt(mesa)) {
                        if (
                            pedido.status !== 'cancelado' &&
                            pedido.status !== 'pago'
                        ) {
                            axios
                                .get('http://localhost:8080/admin/pratos/')
                                .then(function (response) {
                                    const pratos = response.data
                                    pratos.map((prato) => {
                                        if (prato.nome === pedido.prato) {
                                            dinheiro += prato.preco
                                            return setValor(
                                                'Total: R$ ' + dinheiro
                                            )
                                        }
                                        return ''
                                    })
                                })

                                .catch(function (error) {
                                    console.error(error)
                                })
                        }
                    }
                    return ''
                })
            })
            .catch(function (error) {
                console.error(error)
            })
    }
    const changeMesa = (e) => {
        setMesa(e.target.value)
    }
    useEffect(() => {
        console.log(pedidoFechado)
    }, [pedidoFechado])
    return (
        <>
            <div className="adminForm">
                <h1>Fechar pedido</h1>
                <label htmlFor="usuario">Mesa</label>
                <input type="number" value={mesa} onChange={changeMesa} />
                <button
                    onClick={() => {
                        fecharPedido()
                    }}
                >
                    Fechar Pedido
                </button>
            </div>
            {pedidoFechado ? <p className="total"> {valor}</p> : <></>}
        </>
    )
}
