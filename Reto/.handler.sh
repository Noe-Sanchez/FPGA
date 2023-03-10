entity=$(cat ./VHLists | grep TOP | sed "s/TOP //" | sed "s/.vhd//")

case $1 in
        analyze)
                echo "- Analyzing design and testbench files..."
                for file in $(cat ./VHLists | sed "s/TOP //g" | tr "\n" " "); do \
                        ghdl -a $file \
                        && (echo "Hit $file") \
                        || (echo "! Error at $file" && exit 1); \
                done
        ;;

        integrate)
                echo "- Consolidating entity $entity ..."
                ghdl -e $entity \
                && echo "Consolidated $entity" \
                || echo "! Error while consolidating entity $entity"
        ;;

        run)
                ghdl -r $entity --vcd=$entity.vcd \
                || echo "! Error at runtime"
        ;;

        open)
                gtkwave ./$entity.vcd \
                || echo "! Error while displaying wave"
        ;;
esac