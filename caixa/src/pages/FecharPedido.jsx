import axios from 'axios'
import React, { useEffect, useState } from 'react'
import './FecharPedido.css'
export function FecharPedido() {
    const [pedidoFechado, setPedidoFechado] = useState(false)
    const [pratos, setPratos] = useState([])
    const [valor, setValor] = useState(0)
    const [mesa, setMesa] = useState(0)
    const [ativo, setAtivo] = useState('Ver Pedido')
    const fecharPedido = () => {
        setValor('Esta mesa não tem pedidos')
        setPedidoFechado(true)
        setPratos([])
        let dinheiro = 0
        let listaPratos = []
        axios
            .get('http://localhost:8080/admin/pedidos/')
            .then(function (response) {
                console.log(
                    'Ativo?' + (ativo.toString() === 'Ver Pedido').toString()
                )
                const pedidos = response.data
                pedidos.map((pedido) => {
                    if (pedido.idMesa === parseInt(mesa)) {
                        if (
                            pedido.status !== 'cancelado' &&
                            pedido.status !== 'pago'
                        ) {
                            console.log(pedido.prato)
                            axios
                                .get('http://localhost:8080/admin/pratos/')
                                .then(function (response) {
                                    const pratos = response.data
                                    pratos.map((prato) => {
                                        if (prato.nome === pedido.prato) {
                                            dinheiro += prato.preco
                                            if (listaPratos.length !== 0) {
                                                listaPratos.push(' - ')
                                            }
                                            listaPratos.push(
                                                prato.nome + ' R$' + prato.preco
                                            )

                                            return setValor(
                                                'Total: R$ ' + dinheiro
                                            )
                                        }
                                        setAtivo('Fechar Pedido')
                                        setPratos(listaPratos)
                                        return ''
                                    })
                                })
                                .then(() => {
                                    setAtivo('Fechar Pedido')
                                    console.log('Ativo aqui' + ativo.toString())
                                    if (ativo.toString() === 'Fechar Pedido') {
                                        console.log(
                                            'http://localhost:8080/admin/pedidos/atualizaStatus/' +
                                                pedido.id
                                        )
                                        axios
                                            .get(
                                                'http://localhost:8080/admin/pedidos/atualizaStatus/' +
                                                    pedido.id
                                            )
                                            .then(() => {
                                                setAtivo('Ver Pedido')
                                            })
                                        setValor('Pedido da mesa fechado')
                                        setPratos([])
                                    }
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
                    {ativo}
                </button>
            </div>
            {pedidoFechado ? <p className="total"> {valor}</p> : <></>}
            <p className="pratos">{pratos}</p>
        </>
    )
}
