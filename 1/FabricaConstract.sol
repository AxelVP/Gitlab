// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.10;

contract FabricaConstract{
    uint idDigits = 16;

    struct Producto{
        string nombre;
        uint id;
    }

    Producto[] productos;

    function _crearProducto(string memory _nombre, uint _id) private {
        productos.push(Producto(_nombre, _id));
        emit NuevoProducto(productos.length-1, _nombre, _id);

    }

    function _generarIdAleatorio(string memory _str) private view returns (uint){
        uint _rand = uint(keccak256(abi.encodePacked(_str)));
        uint _idModulo = 10^idDigits;
        return _rand % _idModulo;
    }

    function crearProductoAleatorio(string memory _nombre) public {
        uint _randID = _generarIdAleatorio(_nombre);
        _crearProducto(_nombre, _randID);
    }

    event NuevoProducto(uint _ArryProductoId, string _nombre, uint _id);

    mapping (uint => address) public productoAPropietario;

    mapping (address => uint) public propietarioProductos;

    function _Propiedad(uint _productoId) public {
        productoAPropietario[_productoId] = msg.sender;
        propietarioProductos[msg.sender] = _productoId;
    }

    function getProductosPorPropietario(address _propietario) external view returns (uint[] memory) {
        uint contador = 0;
        uint x = propietarioProductos[_propietario];
        uint[] memory resultado = new uint[](x);

        for (uint i=0; i<=resultado.length; i++){
            if(productoAPropietario[i] == _propietario){
                resultado[contador] = propietarioProductos[productoAPropietario[i]];
                contador++;

            }
            
        }
        return resultado;
    }

}
