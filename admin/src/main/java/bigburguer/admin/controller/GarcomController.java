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
@CrossOrigin(origins = "http://localhost:3000")
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
                    g.setCargo(garcom.getCargo());
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

    @PostMapping(path = "/garcom/login")
    public ResponseEntity login(@RequestBody @NotNull GarcomModel garcom) {
        System.out.println("oi");
        for (GarcomModel g : repository.findAll()) {
            System.out.println(garcom.getLogin()+ garcom.getSenha());
            if (g.getLogin().equals(garcom.getLogin())) {
                if (g.getSenha().equals((garcom.getSenha()))) {
                    return ResponseEntity.ok().body("ok");
                }

            }
        }
        return ResponseEntity.notFound().build();
    }
}
