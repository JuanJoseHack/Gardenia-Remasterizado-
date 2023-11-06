package GardeniaProyect.Gardenia.app.service;

import GardeniaProyect.Gardenia.infrastructure.entity.Usuario;
import java.util.List;
import java.util.Optional;



public interface IUsuarioService {

    List<Usuario> findAll();

    Optional<Usuario> findById(Integer id);

    Usuario save(Usuario usuario);

    Optional<Usuario> findByEmail(String email);

}