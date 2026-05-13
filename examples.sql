CALL complete_repair_job(
	7,			 -- id
	'2026-05-12' -- completion date
);

SELECT 
	j.job_id,
    j.price, 
    j.ongoing,
    j.start_date ,
    j.completion_date,
    e.f_name AS 'employee_f_name', 
    c.f_name AS 'client_f_name'
FROM jobs j 
JOIN clients c ON c.client_id = j.client_id 
JOIN employees e ON e.employee_id = j.assigned_employee_id 
WHERE j.job_id = 7;

CALL create_repair_job( 
 	-- JOB --  
	7, 										 -- id                      
	2, 										 -- assigned employee                                                                    
	3, 										 -- client                                                                                    
	199.99, 								 -- repair cost                
	0, 										 -- ongoing (T/F)                                                                                  
	'2026-05-11', 							 -- start date                                                                     
	NULL, 									 -- end date  
	-- DETAILS --               
	7, 										 -- details id                                                                                  
	'Replacing cracked screen on iPhone 14', -- description                                               
	'Screen Repair' 						 -- type of repair                                                                        
);

SELECT j.*, d.description, d.repair_type 
FROM jobs j 
JOIN job_details d ON j.job_id = d.job_id 
WHERE j.job_id = 7;