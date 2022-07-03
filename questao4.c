#include <stdio.h>

float percentual(float *valor, float *total){
    float resul;
    return resul = (*(valor) * 100) / *total;
}

int main(){
    
    float total = 0;
    float sp = 67836.43, rj = 36678.66, mg = 29229.88, es = 27165.48, outros = 19849.53;
    
    total = sp+rj+mg+es+outros;
    
    printf("\n=================================================================\n");
    printf("\nTotal do faturamento mensal da distribuidora: R$ %.2f\n\n", total);
    printf("Percentual de faturamento que representa o estado de SP: %.2f%%\n", percentual(&sp, &total));
    printf("Percentual de faturamento que representa o estado de RJ: %.2f%%\n", percentual(&rj, &total));
    printf("Percentual de faturamento que representa o estado de MG: %.2f%%\n", percentual(&mg, &total));
    printf("Percentual de faturamento que representa o estado de ES: %.2f%%\n", percentual(&es, &total));
    printf("Percentual de faturamento que representa o restante dos estados: %.2f%%\n", percentual(&outros, &total));
    printf("\n=================================================================\n\n");

    return 0;
}