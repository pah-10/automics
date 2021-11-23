class Mecanico {
  final String email;
  final String senha;
  final String nome;

  Mecanico(this.email, this.senha, this.nome);
}

class Cliente {
  final String nome;
  final String cpf;
  final String dtNascimento;
  final String telefone;
  final String email;
  final String endereco;

  Cliente(this.nome, this.cpf, this.dtNascimento, this.telefone, this.email, this.endereco);
}

enum OpcoesRadio {carro, moto}

class Veiculo {
  final String placa;
  final String modelo;
  final String marca;
  final String ano;
  final String km;
  final String cor;
 // final OpcoesRadio tipo;

  Veiculo(this.placa, this.modelo, this.marca, this.ano, this.km, this.cor/*,this.tipo*/);
}