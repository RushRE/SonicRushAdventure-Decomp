#include <sail/sailEventManager.h>

#include <sail/sailCommonObjects.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED StageTask *SailJetBob__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailJetShark__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailJetBird__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailJetJumpRamp__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailJetCreateDashPanel(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailHoverEnemyHover1__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailHoverEnemyHover2__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailHoverBoat02__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailHoverBoat01__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailHoverBob__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailHoverBobBird__Create(SailEventManagerObject *mapObject);

NOT_DECOMPILED StageTask *SailSailerBoat03__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerBoat02__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerBigBob01__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerBigBob02__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerCruiser__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerBird__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerBoat01__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerBoat02_2__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSailerCruiser02__Create(SailEventManagerObject *mapObject);

NOT_DECOMPILED StageTask *SailSubItem__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSubBoat02__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSubMine__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSubShark__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSubMine2__Create(SailEventManagerObject *mapObject);
NOT_DECOMPILED StageTask *SailSubDepth__Create(SailEventManagerObject *mapObject);

// --------------------
// VARIABLES
// --------------------

const SailObjectSpawnFunc sailObjectSpawnList[SAILMAPOBJECT_TYPE_COUNT][SAILMAPOBJECT_COUNT] = {
    [SAILMAPOBJECT_TYPE_JET_HOVER] = {
        [SAILMAPOBJECT_NONE]  = NULL,                                              
        [SAILMAPOBJECT_RING]  = NULL,                                              
        [SAILMAPOBJECT_2]  = (SailObjectSpawnFunc)SailJetItem__Create,          
        [SAILMAPOBJECT_3]  = (SailObjectSpawnFunc)SailJetMine__Create,          
        [SAILMAPOBJECT_4]  = (SailObjectSpawnFunc)SailJetBob__Create,           
        [SAILMAPOBJECT_5]  = (SailObjectSpawnFunc)SailJetShark__Create,         
        [SAILMAPOBJECT_6]  = (SailObjectSpawnFunc)SailJetShark__Create,         
        [SAILMAPOBJECT_7]  = (SailObjectSpawnFunc)SailJetBird__Create,          
        [SAILMAPOBJECT_8]  = (SailObjectSpawnFunc)SailJetJumpRamp__Create,      
        [SAILMAPOBJECT_9]  = (SailObjectSpawnFunc)SailJetCreateDashPanel,       
        [SAILMAPOBJECT_10] = (SailObjectSpawnFunc)SailJetJumpRamp__Create,      
        [SAILMAPOBJECT_11] = (SailObjectSpawnFunc)SailJetBob__Create,           
        [SAILMAPOBJECT_12] = (SailObjectSpawnFunc)SailJetBird__Create,          
        [SAILMAPOBJECT_13] = (SailObjectSpawnFunc)SailJetBomber__Create,        
        [SAILMAPOBJECT_14] = (SailObjectSpawnFunc)SailHoverEnemyHover1__Create, 
        [SAILMAPOBJECT_15] = (SailObjectSpawnFunc)SailHoverEnemyHover1__Create, 
        [SAILMAPOBJECT_16] = (SailObjectSpawnFunc)SailHoverEnemyHover2__Create, 
        [SAILMAPOBJECT_17] = (SailObjectSpawnFunc)SailHoverEnemyHover2__Create, 
        [SAILMAPOBJECT_18] = (SailObjectSpawnFunc)SailHoverBoat02__Create,      
        [SAILMAPOBJECT_19] = (SailObjectSpawnFunc)SailHoverBoat01__Create,      
        [SAILMAPOBJECT_20] = (SailObjectSpawnFunc)SailHoverBob__Create,         
        [SAILMAPOBJECT_21] = (SailObjectSpawnFunc)SailHoverBobBird__Create,     
        [SAILMAPOBJECT_22] = (SailObjectSpawnFunc)SailHoverBobBird__Create,     
        [SAILMAPOBJECT_23] = (SailObjectSpawnFunc)SailHoverBobBird__Create,     
        [SAILMAPOBJECT_24] = (SailObjectSpawnFunc)SailHoverBobBird__Create,     
        [SAILMAPOBJECT_25] = (SailObjectSpawnFunc)SailHoverBobBird__Create,     
        [SAILMAPOBJECT_26] = (SailObjectSpawnFunc)SailStone__Create,            
        [SAILMAPOBJECT_27] = NULL,                                              
        [SAILMAPOBJECT_28] = NULL,                                              
        [SAILMAPOBJECT_29] = NULL,                                              
        [SAILMAPOBJECT_30] = NULL,                                              
        [SAILMAPOBJECT_31] = (SailObjectSpawnFunc)SailBuoy__Create,             
        [SAILMAPOBJECT_32] = (SailObjectSpawnFunc)SailSeagull__Create,          
        [SAILMAPOBJECT_33] = (SailObjectSpawnFunc)SailStone__Create,            
        [SAILMAPOBJECT_34] = (SailObjectSpawnFunc)SailIce__Create,              
        [SAILMAPOBJECT_35] = (SailObjectSpawnFunc)SailSeagull2__Create,         
        [SAILMAPOBJECT_36] = (SailObjectSpawnFunc)SailSubFish__Create,          
        [SAILMAPOBJECT_37] = (SailObjectSpawnFunc)SailJetBoatCloud__Create,     
    },

    [SAILMAPOBJECT_TYPE_BOAT] = {
        [SAILMAPOBJECT_NONE]  = NULL,                                             
        [SAILMAPOBJECT_RING]  = NULL,                                             
        [SAILMAPOBJECT_2]  = (SailObjectSpawnFunc)SailJetItem__Create,         
        [SAILMAPOBJECT_3]  = (SailObjectSpawnFunc)SailSailerBoat03__Create,    
        [SAILMAPOBJECT_4]  = (SailObjectSpawnFunc)SailSailerBoat03__Create,    
        [SAILMAPOBJECT_5]  = (SailObjectSpawnFunc)SailSailerBoat03__Create,    
        [SAILMAPOBJECT_6]  = (SailObjectSpawnFunc)SailSailerBoat03__Create,    
        [SAILMAPOBJECT_7]  = (SailObjectSpawnFunc)SailSailerBoat02__Create,    
        [SAILMAPOBJECT_8]  = (SailObjectSpawnFunc)SailSailerBoat02__Create,    
        [SAILMAPOBJECT_9]  = (SailObjectSpawnFunc)SailSailerBoat02__Create,    
        [SAILMAPOBJECT_10] = (SailObjectSpawnFunc)SailSailerBoat02__Create,    
        [SAILMAPOBJECT_11] = (SailObjectSpawnFunc)SailSailerBigBob01__Create,  
        [SAILMAPOBJECT_12] = (SailObjectSpawnFunc)SailSailerBigBob01__Create,  
        [SAILMAPOBJECT_13] = (SailObjectSpawnFunc)SailSailerBigBob02__Create,  
        [SAILMAPOBJECT_14] = (SailObjectSpawnFunc)SailSailerCruiser__Create,   
        [SAILMAPOBJECT_15] = (SailObjectSpawnFunc)SailSailerCruiser__Create,   
        [SAILMAPOBJECT_16] = (SailObjectSpawnFunc)SailSailerCruiser__Create,   
        [SAILMAPOBJECT_17] = (SailObjectSpawnFunc)SailSailerCruiser__Create,   
        [SAILMAPOBJECT_18] = (SailObjectSpawnFunc)SailSailerBird__Create,      
        [SAILMAPOBJECT_19] = (SailObjectSpawnFunc)SailSailerBird__Create,      
        [SAILMAPOBJECT_20] = (SailObjectSpawnFunc)SailSailerBird__Create,      
        [SAILMAPOBJECT_21] = (SailObjectSpawnFunc)SailSailerBoat01__Create,    
        [SAILMAPOBJECT_22] = (SailObjectSpawnFunc)SailSailerBoat02_2__Create,  
        [SAILMAPOBJECT_23] = (SailObjectSpawnFunc)SailSailerCruiser02__Create, 
        [SAILMAPOBJECT_24] = (SailObjectSpawnFunc)SailSailerBird__Create,      
        [SAILMAPOBJECT_25] = (SailObjectSpawnFunc)SailSailerBird__Create,      
        [SAILMAPOBJECT_26] = (SailObjectSpawnFunc)SailSailerBigBob01__Create,  
        [SAILMAPOBJECT_27] = (SailObjectSpawnFunc)SailSailerBoat03__Create,    
        [SAILMAPOBJECT_28] = (SailObjectSpawnFunc)SailSailerBoat02__Create,    
        [SAILMAPOBJECT_29] = (SailObjectSpawnFunc)SailJetMine__Create,         
        [SAILMAPOBJECT_30] = (SailObjectSpawnFunc)SailStone__Create,           
        [SAILMAPOBJECT_31] = (SailObjectSpawnFunc)SailBuoy__Create,            
        [SAILMAPOBJECT_32] = (SailObjectSpawnFunc)SailSeagull__Create,         
        [SAILMAPOBJECT_33] = (SailObjectSpawnFunc)SailStone__Create,           
        [SAILMAPOBJECT_34] = (SailObjectSpawnFunc)SailIce__Create,             
        [SAILMAPOBJECT_35] = (SailObjectSpawnFunc)SailSeagull2__Create,        
        [SAILMAPOBJECT_36] = (SailObjectSpawnFunc)SailSubFish__Create,         
        [SAILMAPOBJECT_37] = (SailObjectSpawnFunc)SailJetBoatCloud__Create,    
    },

    [SAILMAPOBJECT_TYPE_SUBMARINE] = {
        [SAILMAPOBJECT_NONE]  = NULL,                                       
        [SAILMAPOBJECT_RING]  = NULL,                                       
        [SAILMAPOBJECT_2]  = (SailObjectSpawnFunc)SailSubItem__Create,   
        [SAILMAPOBJECT_3]  = (SailObjectSpawnFunc)SailSubBoat02__Create, 
        [SAILMAPOBJECT_4]  = (SailObjectSpawnFunc)SailSubMine__Create,   
        [SAILMAPOBJECT_5]  = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_6]  = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_7]  = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_8]  = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_9]  = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_10] = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_11] = (SailObjectSpawnFunc)SailSubMine2__Create,  
        [SAILMAPOBJECT_12] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_13] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_14] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_15] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_16] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_17] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_18] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_19] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_20] = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_21] = (SailObjectSpawnFunc)SailSubShark__Create,  
        [SAILMAPOBJECT_22] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_23] = (SailObjectSpawnFunc)SailSubDepth__Create,  
        [SAILMAPOBJECT_24] = NULL,                                       
        [SAILMAPOBJECT_25] = NULL,                                       
        [SAILMAPOBJECT_26] = NULL,                                       
        [SAILMAPOBJECT_27] = NULL,                                       
        [SAILMAPOBJECT_28] = NULL,                                       
        [SAILMAPOBJECT_29] = NULL,                                       
        [SAILMAPOBJECT_30] = NULL,                                       
        [SAILMAPOBJECT_31] = (SailObjectSpawnFunc)SailBuoy__Create,      
        [SAILMAPOBJECT_32] = (SailObjectSpawnFunc)SailSeagull__Create,   
        [SAILMAPOBJECT_33] = (SailObjectSpawnFunc)SailStone__Create,     
        [SAILMAPOBJECT_34] = (SailObjectSpawnFunc)SailIce__Create,       
        [SAILMAPOBJECT_35] = (SailObjectSpawnFunc)SailSeagull2__Create,  
        [SAILMAPOBJECT_36] = (SailObjectSpawnFunc)SailSubFish__Create,   
        [SAILMAPOBJECT_37] = NULL,                                       
    },
};