byte codigo_oper;
byte operando_1_sm;
byte operando_2_sm;
byte resultado_i;
byte operando_1_ip;
byte operando_2_ip;
void main() {
	if(operando_1_sm >= 0){
		operando_1_ip = operando_1_sm;
	} else {
		operando_1_ip = !operando_1_sm;
		operando_1_ip = operando_1_ip + 128;
		operando_1_ip = !operando_1_ip;
	}

	codigo_oper = codigo_oper + 255;
	if(codigo_oper !=0){
		codigo_oper = codigo_oper + 254;
		if(codigo_oper !=0){
			codigo_oper = codigo_oper + 252;
			if(codigo_oper !=0){
				resultado_i = 0;
			} else {
				resultado_i = 0;
			}
		} else {
			resultado_i = operando_1_ip + !operando_2_ip;
		}
	} else {
		resultado_i = operando_1_ip + operando_2_ip;
	}
}
