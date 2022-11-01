package bigburguer.admin.controller;


import bigburguer.admin.model.PedidoModel;
import bigburguer.admin.repository.PedidoRepository;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "http://localhost:3000")
public class PedidoController {
    @Autowired
    private PedidoRepository repository;

    @GetMapping(path = "/admin/pedidos")
    public List<PedidoModel> todosCadastrados() {
        return (List<PedidoModel>) repository.findAll();
    }
    @GetMapping(path = "/admin/pedidos/esperando")
    public List<PedidoModel> pedidosEsperando() {

        return (List<PedidoModel>) repository.filterStatus("esperando");
    }
    @GetMapping(path = "/admin/pedidos/pronto")
    public List<PedidoModel> pedidosPronto() {

        return (List<PedidoModel>) repository.filterStatus("pronto");
    }
    @GetMapping(path = "/admin/pedidos/entregue")
    public List<PedidoModel> pedidosEntregue() {

        return (List<PedidoModel>) repository.filterStatus("entregue");
    }
    @PostMapping(path = "/admin/pedidos")
    public ResponseEntity salvar(@RequestBody @NotNull PedidoModel pedido) {
        try{
            repository.save(pedido);
            return ResponseEntity.ok().body("ok");
        }catch (Exception e){
            return ResponseEntity.noContent().build();
        }



    }
    @GetMapping("/admin/pedidos/atualizaStatus/{id}")
    public Optional<PedidoModel> atualizaStatus(@PathVariable Integer id) {

        return repository.findById(id)
                .map(p-> {
                    if(p.getStatus().equals("pronto")){
                        p.setStatus("entregue");
                        return repository.save(p);
                    }
                    if(p.getStatus().equals("esperando")){
                        p.setStatus("pronto");
                        return repository.save(p);
                    }

                    return repository.save(p);
                });

    }
}
