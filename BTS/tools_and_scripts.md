# Tools and Scripts that could serve useful
-- Some might have been taken from other schools.

# Install and run vuln checks for go
```bash
go install golang.org/x/vuln/cmd/govulncheck@latest
govulncheck ./...  #on root folder with go.mod
```

# Install other teams tools 

## TOTP script
```bash
wget https://raw.githubusercontent.com/nationalcptc-teamtools/University-of-California-Irvine/refs/heads/main/scripts/totp.py
totp.py 'otpauth://totp/Issuer:user@x?secret=stp&algorithm=['algo']&digit=['num']&period=120'
```
