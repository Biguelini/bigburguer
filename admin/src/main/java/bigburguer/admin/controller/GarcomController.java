package bigburguer.admin.controller;

import bigburguer.admin.model.GarcomModel;
import bigburguer.admin.repository.GarcomRepository;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.function.Consumer;

@RestController
public class GarcomController {

    @Autowired
    private GarcomRepository repository;
    @GetMapping(path = "/admin/garcom")
    public List<GarcomModel> todosCadastrados() {
        return (List<GarcomModel>) repository.findAll();
    }
    @GetMapping(path = "/admin/garcom/{id}")
    public ResponseEntity consultar(@PathVariable("id") Integer id) {
        return repository.findById(id)
                .map(record -> ResponseEntity.ok().body(record))
                .orElse(ResponseEntity.notFound().build());
    }
    @PostMapping(path = "/admin/garcom")
    public GarcomModel salvar(@RequestBody @NotNull GarcomModel garcom) throws Exception {
        for (GarcomModel g : repository.findAll()) {
            if (g.getCpf().equals( garcom.getCpf())) {
                return null;

            }
        }
        return repository.save(garcom);
    }
    @PutMapping("/admin/garcom/{id}")
    public GarcomModel atualiza(@RequestBody GarcomModel garcom, @PathVariable Integer id) {

        return repository.findById(id)
                .map(g -> {
                    g.setNome(garcom.getNome());
                    g.setCpf(garcom.getCpf());
                    g.setLogin(garcom.getLogin());
                    g.setSenha(garcom.getSenha());
                    g.setTelefone(garcom.getTelefone());
                    return repository.save(g);
                })
                .orElseGet(() -> {
                    garcom.setId(id);
                    return repository.save(garcom);
                });
    }
    @DeleteMapping("/admin/garcom/{id}")
    void delete(@PathVariable Integer id) {
        repository.deleteById(id);
    }
}
