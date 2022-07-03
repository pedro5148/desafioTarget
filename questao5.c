#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *inverterRetorno(char texto[]){
    int i, aux, fim, tam = strlen(texto);
    // tam + 1 para o caracter nulo
    char *novo = (char *) malloc((tam + 1) * sizeof(char));

    fim = tam - 1;
    for (i = 0; i < tam; i++){
        novo[fim] = texto[i];
        fim--;
    }
    novo[i] = '\0';
    return novo;
}

int main(){
    char *texto = (char *) malloc(sizeof(char));
    char *p;
    
    printf("Digite uma palavra: "); scanf(" %[^\n]", texto);

    p = inverterRetorno(texto);
    
    printf("A palavra invertido é: %s\n", p);
    free(p);
    return 0;
}