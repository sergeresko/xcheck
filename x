./xcheck 1 $1 > xout_ft.txt && \
./xcheck 2 $1 > xout_libc.txt && \
diff xout_ft.txt xout_libc.txt
