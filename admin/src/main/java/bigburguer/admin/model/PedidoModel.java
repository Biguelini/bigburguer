package bigburguer.admin.model;

import javax.persistence.*;

@Entity(name = "pedido")
public class PedidoModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(nullable = false, length = 11)
    private Integer idMesa;
    @Column(nullable = false, length = 100)
    private String prato;
    @Column(nullable = false, length = 25)
    private String status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdMesa() {
        return idMesa;
    }

    public void setIdMesa(Integer idMesa) {
        this.idMesa = idMesa;
    }

    public String getprato() {
        return prato;
    }

    public void setprato(String prato) {
        this.prato = prato;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
