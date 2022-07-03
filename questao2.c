#include <stdio.h>

int main(){
	int num1 = 0, num2 = 1, aux = 0;
    //int x = 55;
	int x;

	printf("Digite o numero a ser verificado se pertence a sequencia de Fibonacci: "); scanf("%d",&x);

	printf("\n\tSEQUENCIA DE FIBONACCI\n\n");

    while (x > aux) {
        aux = num1 + num2;      //soma o primeiro com o segundo 0+1=1
        num1 = num2;            //num2 é vale 1, num1 agora vale 1
        num2 = aux;
    }

    if (x == 0){
        printf("O numero %d esta na sequencia, o proximo é 1\n", x);
    } else if (x == aux) {
        printf("O numero %d esta na sequencia, o proximo é %d\n", x, (x + num1));
    } else {
        printf("O numero %d NAO pertence a na sequencia\n", x);
    }
    
return 0;
}