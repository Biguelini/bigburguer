/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bigburguer.admin.controller;

import bigburguer.admin.models.Garcom;
import bigburguer.admin.repository.GarcomRepository;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author 2info2021
 */
@RestController
@RequestMapping({"/garcom"})
public class GarcomController {

    GarcomRepository repository;

    GarcomController(GarcomRepository garcomRepository) {
        this.repository = garcomRepository;
    }

    @GetMapping
    public List findAll() {
        return repository.findAll();
    }

    @GetMapping(path = {"/{id}"})
    public ResponseEntity<Garcom> findById(@PathVariable int id) {
        return repository.findById(id)
                .map(record
                        -> ResponseEntity.ok().body(record))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Garcom create(@RequestBody Garcom contato) {
        return repository.save(contato);
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Garcom>
            update(@PathVariable("id") int id,
                    @RequestBody Garcom garcom) {
        return repository.findById(id)
                .map(record -> {
                    record.setNome(garcom.getNome());
                    record.setEmail(garcom.getEmail());

                    record.setTelefone(garcom.getTelefone());
                    record.setCpf(garcom.getCpf());
                    Garcom atualizado = repository.save(record);
                    return ResponseEntity.ok().body(atualizado);
                }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping(path = {"/{id}"})
    public ResponseEntity<?> delete(@PathVariable("id") int id) {
        return repository.findById(id)
                .map(record -> {
                    repository.deleteById(id);

                    return ResponseEntity.ok().build();

                }).orElse(ResponseEntity.notFound().build());
    }
}
