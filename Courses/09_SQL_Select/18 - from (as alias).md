# **`FROM (AS ALIAS)`**

```JS
. . . FROM table. . .
```

Cette notion a déjà été et il s'agit de la version la plus imple. Il n'existe pas de nombreuses variantes du `FROM` mais une doit particulièrement être étudiée : le [`JOIN`]().

## AS ALIAS

```JS
SELECT surname,
       name,
       date_birth,
       city,
       country
  FROM zdriver_car AS d
  INTO TABLE @DATA(t_driver)
  WHERE EXISTS ( SELECT * FROM zpassenger
                   WHERE surname = d~surname
                     AND name    = d~name ).


DATA s_driver LIKE LINE OF t_driver.

LOOP AT t_driver INTO s_driver.
  WRITE:/ s_driver-surname, s_driver-name, s_driver-date_birth,
          s_driver-city,    s_driver-country.
ENDLOOP.
```
