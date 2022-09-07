import 'dart:io';

import 'data.dart';
import 'vending_machine.dart';

Money userMoney = Money(money: 0);
MyVendingMachine myVendingMachine = MyVendingMachine();

void main() {
  myVendingMachine.init();
}

class MyVendingMachine extends VendingMachine {

  @override
  void init({
    showError = false,
    errorMessage = ''
  }) {
    clearConsole();

    if(showError) {
      stdout.write(errorMessage);
    }

    stdout.write('Selamat datang di Vending Machine!\n');
    stdout.write('\nUang Anda : Rp.${userMoney.money.ceil()} \n');
    stdout.write('\na. Lakukan Top Up!');
    stdout.write('\nb. Beli makanan');
    stdout.write('\nx. untuk keluar\n');
    stdout.write('\nSilahkan masukan pilihan anda : '); 
    final chooseMenu = stdin.readLineSync();
    
    if(chooseMenu == 'a') {
      topup();
    } else if(chooseMenu == 'b') {
      buying();
    } else if(chooseMenu == 'x') {
      change();
    } else {
      init(showError: true, errorMessage: notValid());
    }
  }
  
  @override
  void topup({
    showError = false,
    errorMessage = ''
  }) {
    clearConsole();

    if(showError) {
      stdout.write(errorMessage);
    }
    
    stdout.write('\n[ Top up section ] - Pecahan Uang yang diterima \n\n');
    for (Money item in acceptableMoney) print('--> Rp. ${item.money.ceil()}');
    stdout.write('\nx. untuk keluar\n');
    stdout.write('\nMasukan Uang Anda : ');
    
    final inputMoney = stdin.readLineSync();

      if(inputMoney == 'x') {
        init();
      } else {
        try {
          if(double.parse(inputMoney!) > 0) {
            if(acceptableMoney.any((money) => money.money == double.parse(inputMoney))) {
              userMoney.money = userMoney.money + double.parse(inputMoney);
              init();
            } else {
              topup(showError: true, errorMessage: notValid());
            }
          } else {
            topup(showError: true, errorMessage: notValid());
          }
        } catch (error) {
          topup(showError: true, errorMessage: notValid());
        }
      }
  }

  @override
  void buying({
    reload = false,
    successMessage = '',
    showError = false,
    errorMessage = '',
  }) {

    clearConsole();

    if(reload) {
      stdout.write(successMessage);
    }

    if(showError) {
      stdout.write(errorMessage);
    }
    
    stdout.write('\n[ Menu section ] - Jumlah uang anda : Rp.${userMoney.money.ceil()}\n\n');
    for (Menu item in menu) print(' --> ${item.mark} : ${item.name} (${item.stock}) : Rp.${item.price.ceil()}');
    stdout.write('\nx. untuk keluar\n');
    stdout.write('\nPilih Makanan yang ingin dibeli (a,b,c,d,e) atau tekan (t) untuk melakukan Top Up : ');
    final choose = stdin.readLineSync();

    try {
      if(choose == 'x') {
        init();
      } else {
        if(menu.any((menu) => menu.mark == choose)) {
        
          Menu selectedMenu = menu.firstWhere((menu) => menu.mark == choose);

          if(selectedMenu.stock <= 0) {
            buying(reload: true, successMessage: outOfStock(selectedMenu.name));
          } else {
            
            if(selectedMenu.price <= userMoney.money) {
              userMoney.money = userMoney.money - selectedMenu.price;
              selectedMenu.stock = selectedMenu.stock - 1;
              itemPurchased.add(selectedMenu);
              stdout.write('\n${selectedMenu.name} berhasil dibeli. silahkan check! \n');
              buying(reload: true, successMessage: successBuying(selectedMenu.name));
            } else {
              stdout.write('\nUang anda tidak cukup! Apakah anda ingin melakukan Top Up? (y/Y) untuk lanjut (n/N) untuk keluar : ');
              final isTopUp = stdin.readLineSync();
              if(isTopUp!.toLowerCase() == 'y') {
                topup();
              } else if(isTopUp.toLowerCase() == 'n') {
                init();
              } else {
                buying(showError: true, errorMessage: notValid());
              }
            }

          }

        } else {
          buying(showError: true, errorMessage: notValid());
        }
      }
    } catch(error) {
      buying(showError: true, errorMessage: notValid());
    }

  }

  @override
  void change({
    showError = false,
    errorMessage = ''
  }) {
    clearConsole();

    if(itemPurchased.isNotEmpty) {
      stdout.write('\nItem(s) yang dibeli: \n');
      for (Menu item in itemPurchased) print(' --> ${item.name} Rp.${item.price.ceil()}');
    }

    if(userMoney.money > 0) {
      stdout.write('\nSisa uang anda sebesar Rp.${userMoney.money.ceil()} telah dikembalikan. silahkan check');
      stdout.write('\nTerimakasih telah menggunakan Vending Machine ini!\n');
    } else {
      stdout.write('\nTerimakasih telah menggunakan Vending Machine ini!\n');
      userMoney = Money(money: 0);
    }
  }

}
