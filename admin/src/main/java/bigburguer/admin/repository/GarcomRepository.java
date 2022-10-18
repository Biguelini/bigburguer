/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bigburguer.admin.repository;

/**
 *
 * @author 2info2021
 */

import bigburguer.admin.models.Garcom;
import org.springframework.data.jpa.repository.JpaRepository;
public interface GarcomRepository extends JpaRepository<Garcom, Integer>{

}
