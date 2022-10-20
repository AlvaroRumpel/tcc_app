enum ReturnType {
  allClear(true, 'sucesso'),
  allError(false, 'verifique as informações'),
  emailError(false, 'email'),
  passwordError(false, 'password'),
  userError(false, 'usuario'),
  heightError(false, 'altura'),
  weightError(false, 'peso'),
  bodyFatError(false, 'gordura corporal'),
  nameError(false, 'nome'),
  lastNameError(false, 'sobrenome'),
  priceError(false, 'preço'),
  phoneError(false, 'celular'),
  cpfError(false, 'CPF'),
  cepError(false, 'CEP'),
  notNumberError(false, 'numero'),
  notAlphabeticError(false, 'escrita'),
  lengthError(false, 'tamanho');

  final bool success;
  final String message;

  const ReturnType(this.success, this.message);
}
