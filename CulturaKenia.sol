// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaKenia
 * @dev Registro de densidades de almidon y tecnicas de asado directo.
 * Serie: Sabores de Africa (7/54)
 */
contract CulturaKenia {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 nivelDensidad;    // Escala de firmeza del Ugali (1-10)
        string metodoAsado;       // Carbon, Lena o Vapor
        bool usaSukumaWiki;       // Acompanamiento base de col rizada
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Ugali con Nyama Choma
        registrarPlato(
            "Ugali con Nyama Choma", 
            "Harina de maiz blanca, agua, carne de cabra, sal.",
            "Cocer harina en agua hirviendo hasta maxima densidad. Asar carne a fuego directo.",
            9, 
            "Carbon de madera dura", 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _densidad, 
        string memory _asado,
        bool _sukuma
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_densidad <= 10, "Escala densidad: 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            nivelDensidad: _densidad,
            metodoAsado: _asado,
            usaSukumaWiki: _sukuma,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 densidad,
        string memory asado,
        bool sukuma,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.nivelDensidad, p.metodoAsado, p.usaSukumaWiki, p.likes);
    }
}
