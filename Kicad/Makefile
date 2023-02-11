PROJECT=LIV2RIDE2K
KIBOT_CONF=./kibot/release.kibot.yaml
GERBER_OUTPUT=../Gerbers

DRILLS=$(GERBER_OUTPUT)/$(PROJECT)-NPTH.drl $(GERBER_OUTPUT)/$(PROJECT)-PTH.drl

GERBERS=$(GERBER_OUTPUT)/$(PROJECT)-B_Cu.gbl $(GERBER_OUTPUT)/$(PROJECT)-B_Mask.gbs $(GERBER_OUTPUT)/$(PROJECT)-B_Silkscreen.gbo $(GERBER_OUTPUT)/$(PROJECT)-Edge_Cuts.gm1 $(GERBER_OUTPUT)/$(PROJECT)-F_Cu.gtl $(GERBER_OUTPUT)/$(PROJECT)-F_Mask.gts $(GERBER_OUTPUT)/$(PROJECT)-F_Silkscreen.gto $(GERBER_OUTPUT)/$(PROJECT)-F_Paste.gtp $(GERBER_OUTPUT)/$(PROJECT)-B_Paste.gbp $(DRILLS)

JLCPCB=$(GERBER_OUTPUT)/$(PROJECT)_bom_jlc.csv $(GERBER_OUTPUT)/$(PROJECT)_cpl_jlc.csv
.PHONY: release


all:	$(GERBERS) $(JLCPCB) ../Docs/Schematic.pdf ../Docs/$(PROJECT)-ibom.html

schematic: ../Docs/Schematic.pdf
gerbers: $(GERBERS)
jlcpcb: $(JLCPCB)
ibom: ../Docs/$(PROJECT)-ibom.html

$(GERBERS) ../Docs/PCB.png:	$(PROJECT).kicad_pcb
	kibot -c $(KIBOT_CONF) Gerbers Drills Image

$(JLCPCB): $(PROJECT).kicad_pcb $(PROJECT).kicad_sch
	kibot -c $(KIBOT_CONF) JLCPCB_position JLCPCB_bom

../Docs/Schematic.pdf:	$(PROJECT).kicad_sch
	kibot -s all -c $(KIBOT_CONF) Schematic

../Docs/$(PROJECT)-ibom.html:	$(PROJECT).kicad_pcb
	kibot -s all -c $(KIBOT_CONF) IBOM
