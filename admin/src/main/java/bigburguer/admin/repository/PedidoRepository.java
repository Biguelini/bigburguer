package bigburguer.admin.repository;

import bigburguer.admin.model.PedidoModel;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PedidoRepository extends CrudRepository<PedidoModel, Integer> {
    @Query("from pedido where status=?1 order by id_mesa")
    public List<PedidoModel> filterStatus(String status);
}
