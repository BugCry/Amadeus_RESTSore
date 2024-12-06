import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Products } from "../model/products.model";
import { ProductsType } from "../model/productsType.model";

@Injectable({
    providedIn: 'root'
})

export class ProductService {
    
    APIURL="https://localhost:44313/api/";

    constructor(private http:HttpClient) { }

    // Products

    get_Products(){
        return this.http.get<Products[]>(this.APIURL+"Product")
    }

    add_Product(body:any){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"Product",body,{headers});
    }
    
    mod_Product(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.put(this.APIURL+"Product/"+id,body,{headers});
    }

    del_Product(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"Product/delete/"+id,body,{headers});
    }

    // Products Types

    get_ProductsType(){
        return this.http.get<ProductsType[]>(this.APIURL+"ProductType")
    }

    add_ProductType(body:any){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"ProductType",body,{headers});
    }
    
    mod_ProductType(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.put(this.APIURL+"ProductType/"+id,body,{headers});
    }

    del_ProductType(body:any,id:number){
        const headers = { 'Content-Type': 'application/json' };
        return this.http.post(this.APIURL+"ProductType/delete/"+id,body,{headers});
    }
}