package bigburguer.admin.controller;


import bigburguer.admin.model.GarcomModel;
import bigburguer.admin.model.PratoModel;
import bigburguer.admin.repository.PratoRepository;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "http://localhost:3000")
public class PratoController {
    @Autowired
    private PratoRepository repository;

    @GetMapping(path = "/admin/pratos")
    public List<PratoModel> todosCadastrados() {
        return (List<PratoModel>) repository.findAll();
    }
    @PostMapping(path = "/admin/pratos")
    public PratoModel salvar(@RequestBody @NotNull PratoModel prato) {
        for (PratoModel p : repository.findAll()) {
            if (p.getNome().equals( prato.getNome())) {
                return null;

            }
        }

        if(prato.getPreco()<=0.0){
            return null;
        }
        return repository.save(prato);
    }
    @PutMapping("/admin/pratos/{id}")
    public PratoModel atualiza(@RequestBody PratoModel prato, @PathVariable Integer id) {

        return repository.findById(id)
                .map(p-> {
                    p.setNome(prato.getNome());
                    p.setPreco(prato.getPreco());
                    return repository.save(p);
                })
                .orElseGet(() -> {
                    prato.setId(id);
                    return repository.save(prato);
                });
    }
    @DeleteMapping("/admin/pratos/{id}")
    void delete(@PathVariable Integer id) {
        repository.deleteById(id);
    }
}
