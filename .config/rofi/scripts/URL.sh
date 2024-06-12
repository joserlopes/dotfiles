#!/usr/bin/env bash

if [ x"$@" = x"CG" ]
then
    xdg-open https://fenix.tecnico.ulisboa.pt/disciplinas/CGra23/2023-2024/2-semestre
    exit 0
elif [ x"$@" = x"Comp" ]
then
    xdg-open https://fenix.tecnico.ulisboa.pt/disciplinas/Com3/2023-2024/2-semestre
    exit 0
elif [ x"$@" = x"PIC" ]
then
    xdg-open https://fenix.tecnico.ulisboa.pt/disciplinas/PLic23-2/2023-2024/2-semestre
    exit 0
elif [ x"$@" = x"GitHub" ]
then
    xdg-open https://github.com/joserlopes
    exit 0
elif [ x"$@" = x"dotfiles" ]
then
    xdg-open https://github.com/joserlopes/.dotfiles/tree/NixOS
    exit 0
fi
echo "CG"
echo "Comp"
echo "PIC"
echo "GitHub"
echo "dotfiles"
