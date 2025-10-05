let print_Binding binding =
	print_string "\x1b[38;5;153m ";
	match binding with
	| (key, sym) -> print_string (sym ^ " -> " ^ (Tsdl.Sdl.get_key_name key));
	print_endline "\x1b[0m"

let print_Key_Mapping key_mapping =
	print_endline "\x1b[38;5;152m-----Key Map-----\x1b[0m";
	List.iter print_Binding key_mapping;
	print_endline "\x1b[38;5;152m-----End-----\x1b[0m"

let print_Error msg =
	print_string "\x1b[38;5;203m";
	print_string msg;
	print_endline "\x1b[0m"

let print_Warning msg =
	print_string "\x1b[38;5;214m";
	print_string msg;
	print_endline "\x1b[0m"

let print_Assigned msg =
	print_string "\x1b[38;5;111m";
	print_string msg;
	print_endline "\x1b[0m"

let print_Combo_Found values =
	if values <> [] then
		begin
			print_endline "************************************************";
			print_string "*            ";
			print_string "\x1b[1;4;5;38;5;111mCombo has been found !\x1b[0m";
			print_endline "            *";
			print_endline "************************************************";
			let rec loop_Print_Values values =
				match values with
				| [] -> print_endline "------------------------------------------------"
				| value :: rest ->
					print_endline ("\x1b[38;5;194m" ^ value ^ "\x1b[0m");
					loop_Print_Values rest
			in
			loop_Print_Values values
		end

let print_Combo combo =
	print_endline "\n------------------------------------------------";
	let split_combo = Str.split (Str.regexp ",") combo in
	let rec print_Combo_split split_combo =
		match split_combo with
		| [] -> ()
		| head :: [] -> 
			print_endline ("\x1b[38;5;147m" ^ head ^ "\x1b[0m")
		| head :: tail ->
			print_string "\x1b[38;5;147m";
			print_string head;
			print_string " | \x1b[0m";
			print_Combo_split tail
	in print_Combo_split split_combo
