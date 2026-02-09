# Compilation
Mini-projet de compilation: analyse lexicale et syntaxique d'un mini-langage.

## Sommaire
- Apercu
- Structure
- Pre-requis
- Build et execution
- Exemples
- Auteur

## Apercu
Ce depot contient un mini compilateur base sur Flex/Bison. Il permet de declarer des variables, effectuer des operations arithmetiques, evaluer des conditions, et executer des blocs `if/else` et `while`.

## Structure
```
mini-projet/
	lexer.l
	parser.y
	lex.yy.c
	y.tab.c
	y.tab.h
	miniscript
	test2.ms
	test22.ms
	test2E.ms
```

## Pre-requis
- Flex
- Bison
- Un compilateur C (gcc/clang)

## Build et execution
Depuis la racine du repo:
```bash
flex -o mini-projet/lex.yy.c mini-projet/lexer.l
bison -d -o mini-projet/y.tab.c mini-projet/parser.y
gcc mini-projet/lex.yy.c mini-projet/y.tab.c -o mini-projet/miniscript
```

Executer un fichier de test:
```bash
mini-projet/miniscript mini-projet/test2.ms
```

## Exemples
Les fichiers [mini-projet/test2.ms](mini-projet/test2.ms) et [mini-projet/test22.ms](mini-projet/test22.ms) contiennent des exemples d'entree du mini-langage.

## Auteur
ELASRI-ELHOUSSAINE
