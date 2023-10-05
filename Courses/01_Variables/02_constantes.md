# **`CONSTANTES`**

> L’instruction commencera par CONSTANTS et devra comporter obligatoirement une valeur fixe avec VALUE.

### **INTEGER**

> ```JS
> CONSTANTS: c_integer TYPE i VALUE 10.
> ```

### **FLOAT**

> ```JS
> CONSTANTS: c_float TYPE f VALUE '3.14'.
> ```

### **DECIMAL**

> ```JS
> CONSTANTS: c_decimal TYPE decfloat34 VALUE '1234567890123456789012345678901234'.
> ```

### **STRING**

> ```JS
> CONSTANTS: c_string TYPE string VALUE 'Hello, World!'.
> ```

### **CHAR**

> ```JS
> CONSTANTS: c_char TYPE C LENGTH 1 VALUE 'F'.
> ```

### **BOOLEAN**

> ```JS
> CONSTANTS: c_bool TYPE boolean VALUE abap_true.
> CONSTANTS: c_boolean TYPE abap_bool VALUE abap_false.
> ```

### **DATE** - AAAAMMJJ

> ```JS
> CONSTANTS: c_date TYPE d VALUE sy-datum.
> CONSTANTS: c_date TYPE d VALUE 1986110.
> ```

### **TIME** - HHMMSS

> ```JS
> CONSTANTS: c_time TYPE t VALUE sy-uzeit.
> CONSTANTS: c_time TYPE t VALUE 183045.
> ```

## **DECIMAL NUMBER**

> Il est à noter qu’en ABAP, le point (.) est utilisé pour les décimales.
>
> Le type `P` doit être accompagné par l’instruction `DECIMALS` qui va définir le nombre de chiffres après la virgule, sinon la variable associée sera considérée comme un nombre entier.
>
> ```JS
> CONSTANTS: c_pi TYPE p DECIMALS 2 VALUE '3.14'.
> ```
