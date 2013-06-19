OUTDOTDIR = dots
OUTGRAPHDIR = graphs

nothing:
	echo "Nothing to make"

clean:
	rm ./$(OUTDOTDIR)/*png ./$(OUTDOTDIR)/*dot ./$(OUTGRAPHDIR)/*png ./decode.log ./encode.log ; ls temp/* | grep -v README.md | xargs rm ; ls encoder/vids/* | grep -v README.md | xargs rm
