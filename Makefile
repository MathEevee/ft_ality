NAME = ft_ality

OBJS = Trie Automate

MLI_FILES += $(OBJS:=.mli)

ML_FILES = $(OBJS:=.ml)
ML_FILES += main.ml

CMI_FILES += $(OBJS:=.cmi)

CMO_FILES = $(OBJS:=.cmo)
CMO_FILES += main.cmo

O_FILES = $(OBJS:=.o)
O_FILES += main.o

CMX_FILES = $(OBJS:=.cmx)
CMX_FILES += main.cmx

OCAMLC = ocamlfind ocamlc
OCAMLOPT = ocamlfind ocamlopt
OCAMLDEP = ocamldep

STR_LIB = str
TSDL_LIB = tsdl

CLEAR = "\033[0K"
CR = "\r"$(CLEAR)
BASENAME = `basename $@`

all: native

byte: $(NAME).occ

$(NAME).occ: $(CMO_FILES)
	@$(OCAMLC) -linkpkg -package $(STR_LIB),$(TSDL_LIB) -thread -o $@ $^
	@printf $(CR)"\e[1m\e[38;5;74m>>> $(NAME).occ is created ! <<<\e[0m\n"

native: $(NAME).lopt

$(NAME).lopt: $(CMX_FILES)
	@$(OCAMLOPT) -linkpkg -package $(STR_LIB),$(TSDL_LIB) -thread -o $@ $^
	@printf $(CR)"\e[1m\e[38;5;74m>>> $(NAME).lopt is created ! <<<\e[0m\n"

%.cmi: %.mli
	@$(OCAMLC) -c $<
	@printf $(CR)"\e[2m\e[38;5;32m>>>\e[0m $(BASENAME)%s \e[2m\e[38;5;32m<<<\e[0m"$(CLEAR)

%.cmo: %.ml $(CMI_FILES)
	@$(OCAMLC) -c -package $(STR_LIB),$(TSDL_LIB) -thread $<
	@printf $(CR)"\e[2m\e[38;5;32m>>>\e[0m $(BASENAME)%s \e[2m\e[38;5;32m<<<\e[0m"$(CLEAR)

%.cmx: %.ml $(CMI_FILES)
	@$(OCAMLOPT) -c -package $(STR_LIB),$(TSDL_LIB) -thread $< 
	@printf $(CR)"\e[2m\e[38;5;32m>>>\e[0m $(BASENAME)%s \e[2m\e[38;5;32m<<<\e[0m"$(CLEAR)

%.o: %.ml
	@$(OCAMLOPT) -c $<
	@printf $(CR)"\e[2m\e[38;5;32m>>>\e[0m $(BASENAME)%s \e[2m\e[38;5;32m<<<\e[0m"$(CLEAR)

depend:
	@$(OCAMLDEP) $(ML_FILES) $(MLI_FILES) > .depend

-include .depend

clean:
	@rm -rf $(CMO_FILES) $(CMI_FILES) $(CMX_FILES) $(O_FILES) main.cmi .depend
	@printf "\e[1m\e[38;5;29mAll object files of $(NAME) are cleaned !\e[0m\n"

fclean: clean
	@rm -rf $(NAME).occ
	@rm -rf $(NAME).lopt
	@printf "\e[1m\e[38;5;36m$(NAME) is cleaned !\e[0m\n"

re : fclean all

reocc : fclean byte

.PHONY: all clean fclean re reocc depend native byte
