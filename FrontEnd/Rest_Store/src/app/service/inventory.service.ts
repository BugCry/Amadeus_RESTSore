import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Inventories } from "../model/inventories.model";

@Injectable({
    providedIn: 'root'
})

export class InventoryService {
    
    APIURL="https://localhost:44313/api/";

    constructor(private http:HttpClient) { }

    // Inventorys

    get_Inventory(){
        return this.http.get<Inventories[]>(this.APIURL+"Inventory")
    }

    add_Inventory(body:any){
        alert("a");
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"Inventory",body,{headers});
    }
    
    mod_Inventory(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.put(this.APIURL+"Inventory/"+id,body,{headers});
    }

    del_Inventory(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"Inventory/delete/"+id,body,{headers});
    }

}