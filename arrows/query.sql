CREATE TABLE vsadssmini_arrow.t_leitung_orientiert AS  
SELECT 
    CASE  
        --WHEN ST_Equals(ST_AsBinary(ST_SnapToGrid(ST_StartPoint(verlauf), 0.001)), ST_AsBinary(ST_SnapToGrid(knoten_start.lage, 0.001))) THEN verlauf
        --ELSE ST_Reverse(verlauf)
        WHEN ST_Equals(ST_AsBinary(ST_SnapToGrid(ST_StartPoint(verlauf), 0.001)), ST_AsBinary(ST_SnapToGrid(knoten_start.lage, 0.001))) THEN verlauf
        ELSE ST_Reverse(verlauf)
    END AS verlauf,
    --verlauf AS verlauf_orig,
    leitung.t_ili_tid, 
    leitung.bezeichnung,
    knoten_vonref,
    knoten_nachref,
    knoten_start.t_id AS knoten_start_t_id,
    knoten_end.t_id AS knoten_end_t_id
    --knoten_start.lage AS knoten_start_geom,
    --knoten_end.lage AS knoten_end_geom 
FROM 
    vsadssmini_arrow.vsadssmini_leitung AS leitung
    LEFT JOIN vsadssmini_arrow.vsadssmini_knoten AS knoten_start
    ON leitung.knoten_vonref = knoten_start.t_id
    LEFT JOIN vsadssmini_arrow.vsadssmini_knoten AS knoten_end
    ON leitung.knoten_nachref = knoten_end.t_id
;



CREATE TABLE vsadssmini_arrow.t_knoten_lage AS
SELECT 
    t_id,
    t_ili_tid,
    bezeichnung,
    lage
FROM 
    vsadssmini_arrow.vsadssmini_knoten 
;