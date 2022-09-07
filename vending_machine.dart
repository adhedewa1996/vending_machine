abstract class VendingMachine {

  void init({
    showError = false,
    errorMessage = ''
  });

  void topup({
    showError = false,
    errorMessage = ''
  });

  void buying({
    reload = false,
    successMessage = '',
    showError = false,
    errorMessage = ''
  });
  
  void change({
    showError = false,
    errorMessage = ''
  });

  void clearConsole() {
    print("\x1B[2J\x1B[0;0H");
  }

  String notValid() {
    return '--------------------------------------------------- \n/////////////// INPUT TIDAK VALID /////////////////\n---------------------------------------------------\n\n';
  }

  String moneyIsNotEnough() {
    return '--------------------------------------------------- \n/////////////// MONEY NOT ENOUGH /////////////////\n---------------------------------------------------\n\n';
  }

  String outOfStock(String item) {
    return '--------------------------------------------------- \n/////////////// ${item.toUpperCase()} SUDAH HABIS /////////////////\n---------------------------------------------------\n\n';
  }

  String successBuying(String item) {
    return '--------------------------------------------------- \n/////////////// ${item.toUpperCase()} BERHASIL DIBELI /////////////////\n---------------------------------------------------\n\n';
  }

}