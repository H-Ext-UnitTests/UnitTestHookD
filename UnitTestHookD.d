module UnitTestHookD;

import std.conv : to;

public import global;
static public import Add_on_API;
pragma(lib, "Add_on_API_OMF.lib");

__gshared uint EAOhashID;

__gshared IUtil* pIUtil = null;
__gshared ICIniFile* pICIniFile = null;
__gshared ICommand* pICommand = null;

const wchar[] iniFileStr = "HookTestD.ini";

const wchar[] eao_unittesthook_saveStr = "eao_unittesthook_save_d";

extern(C) CMD_RETURN eao_unittesthook_save(PlayerInfo plI, ArgContainer* arg, MSG_PROTOCOL protocolMsg, uint idTimer, bool* showChat) {
    if (pICIniFile) {
        pICIniFile.m_save(pICIniFile);
    }
    return CMD_RETURN.SUCCESS;
}

export extern(C) EAO_RETURN EXTOnEAOLoad(uint uniqueHash) {
    EAOhashID = uniqueHash;
    /*pIPlayer = getIPlayer(uniqueHash);
    if (!pIPlayer)
        goto initFail;*/
    pICIniFile = getICIniFile(uniqueHash);
    if (!pICIniFile)
        goto initFail;
    if (pICIniFile.m_open_file(pICIniFile, iniFileStr.ptr)) {
        if (!pICIniFile.m_delete_file(pICIniFile, iniFileStr.ptr)) {
            goto initFail;
        }
        if (pICIniFile.m_open_file(pICIniFile, iniFileStr.ptr)) {
            goto initFail;
        }
    }
    if (!pICIniFile.m_create_file(pICIniFile, iniFileStr.ptr)) {
        goto initFail;
    }
    if (!pICIniFile.m_open_file(pICIniFile, iniFileStr.ptr)) {
        goto initFail;
    }
    pICommand = getICommand(uniqueHash);
    if (!pICommand) {
        goto initFail;
    }
    if (!pICommand.m_add(uniqueHash, eao_unittesthook_saveStr.ptr, &eao_unittesthook_save, EXTPluginInfo.sectors.sect_name1.ptr, 1, 1, 0, modeAll)) {
        goto initFail;
    }
    pIUtil = getIUtil(uniqueHash);
    if (!pIUtil) {
        goto initFail;
    }
    return EAO_RETURN.CONTINUE;
initFail:
    if (pICIniFile) {
        pICIniFile.m_release(pICIniFile);
    }
    if (pICommand) {
        pICommand.m_delete(uniqueHash, &eao_unittesthook_save, eao_unittesthook_saveStr.ptr);
    }
    return EAO_RETURN.FAIL;
}
export extern(C) void EXTOnEAOUnload() {
    if (pICIniFile) {
        pICIniFile.m_save(pICIniFile);
        pICIniFile.m_close(pICIniFile);
        pICIniFile.m_release(pICIniFile);
    }
    if (pICommand) {
        pICommand.m_delete(EAOhashID, &eao_unittesthook_save, eao_unittesthook_saveStr.ptr);
    }
}

const wchar[][] HookNames = [ "EXTOnPlayerJoin"
                            , "EXTOnPlayerQuit"
                            , "EXTOnPlayerDeath"
                            , "EXTOnPlayerChangeTeamAttempt"
                            , "EXTOnPlayerJoinDefault"
                            , "EXTOnNewGame"
                            , "EXTOnEndGame"
                            , "EXTOnObjectInteraction"
                            , "EXTOnWeaponAssignmentDefault"
                            , "EXTOnWeaponAssignmentCustom"
                            , "EXTOnServerIdle"
                            , "EXTOnPlayerScoreCTF"
                            , "EXTOnWeaponDropAttemptMustBeReadied"
                            , "EXTOnPlayerSpawn"
                            , "EXTOnPlayerVehicleEntry"
                            , "EXTOnPlayerVehicleEject"
                            , "EXTOnPlayerSpawnColor"
                            , "EXTOnPlayerValidateConnect"
                            , "EXTOnWeaponReload"
                            , "EXTOnObjectCreate"
                            , "EXTOnKillMultiplier"
                            , "EXTOnVehicleRespawnProcess"
                            , "EXTOnObjectDeleteAttempt"
                            , "EXTOnObjectDamageLookupProcess"
                            , "EXTOnObjectDamageApplyProcess"
                            // Featured in 0.5.1 and newer
                            , "EXTOnMapLoad"
                            , "EXTOnAIVehicleEntry"
                            , "EXTOnWeaponDropCurrent"
                            , "EXTOnServerStatus"
                            // Featured in 0.5.2.3 and newer
                            , "EXTOnPlayerUpdate"
                            , "EXTOnMapReset"
                            // Featured in 0.5.3.0 and newer
                            , "EXTOnObjectCreateAttempt"
                            // Featured in 0.5.3.2 and newer
                            , "EXTOnGameSpyValidationCheck"
                            // Featured in 0.5.3.3 and newer
                            , "EXTOnWeaponExchangeAttempt"
                            // Featured in 0.5.3.4 and newer
                            , "EXTOnObjectDelete" ];

struct checkList {
    int EXTOnPlayerJoin;
    int EXTOnPlayerQuit;
    int EXTOnPlayerDeath;
    int EXTOnPlayerChangeTeamAttempt;
    int EXTOnPlayerJoinDefault;
    int EXTOnNewGame;
    int EXTOnEndGame;
    int EXTOnObjectInteraction;
    int EXTOnWeaponAssignmentDefault;
    int EXTOnWeaponAssignmentCustom;
    int EXTOnServerIdle;
    int EXTOnPlayerScoreCTF;
    int EXTOnWeaponDropAttemptMustBeReadied;
    int EXTOnPlayerSpawn;
    int EXTOnPlayerVehicleEntry;
    int EXTOnPlayerVehicleEject;
    int EXTOnPlayerSpawnColor;
    int EXTOnPlayerValidateConnect;
    int EXTOnWeaponReload;
    int EXTOnObjectCreate;
    int EXTOnKillMultiplier;
    int EXTOnVehicleRespawnProcess;
    int EXTOnObjectDeleteAttempt;
    int EXTOnObjectDamageLookupProcess;
    int EXTOnObjectDamageApplyProcess;
    int EXTOnMapLoad;
    int EXTOnAIVehicleEntry;
    int EXTOnWeaponDropCurrent;
    int EXTOnServerStatus;
    int EXTOnPlayerUpdate;
    int EXTOnMapReset;
    int EXTOnObjectCreateAttempt;
    int EXTOnGameSpyValidationCheck;
    int EXTOnWeaponExchangeAttempt;
    int EXTOnObjectDelete;
};
checkList checkHooks;

enum MAX_HOOK_COUNTER = 5;
const wchar[] nullStr = "NULL";

// List of all available hooks

export extern(C) void EXTOnPlayerJoin(PlayerInfo plI) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerJoin < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerJoin++;
        index = to!wstring(checkHooks.EXTOnPlayerJoin) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTshort(&vars[1], plI.plEx.adminLvl);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, Admin: {1:hd}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[0].ptr, index.ptr, output.ptr);
    }
}

export extern(C) void EXTOnPlayerQuit(PlayerInfo plI) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerQuit < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerQuit++;
        index = to!wstring(checkHooks.EXTOnPlayerQuit) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTshort(&vars[1], plI.plEx.adminLvl);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, Admin: {1:hd}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[1].ptr, index.ptr, output.ptr);
    }
}

export extern(C) void EXTOnPlayerDeath(PlayerInfo killer, PlayerInfo victim, int mode, bool* showMessage) {
    VARIANT[4] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerDeath < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerDeath++;
        index = to!wstring(checkHooks.EXTOnPlayerDeath) ~ "\0";
        VARIANTwstr(&vars[0], killer.plS ? killer.plS.Name.ptr : nullStr.ptr);
        VARIANTwstr(&vars[1], victim.plS ? victim.plS.Name.ptr : nullStr.ptr);
        VARIANTint(&vars[2], mode);
        VARIANTbool(&vars[3], *showMessage);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Killer: {0:s}, Victim: {1:s}, Mode: {2:d}, showMessage: {3:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[2].ptr, index.ptr, output.ptr);
    }
}

export extern(C) bool EXTOnPlayerChangeTeamAttempt(PlayerInfo plI, e_color_team_index team, bool forceChange) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerChangeTeamAttempt < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerChangeTeamAttempt++;
        index = to!wstring(checkHooks.EXTOnPlayerChangeTeamAttempt) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTint(&vars[1], team);
        VARIANTbool(&vars[2], forceChange);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, Team: {1:d}, forceChange: {2:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[3].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it will prevent change team. Unless forceChange is true, this value is ignored.
}

export extern(C) e_color_team_index EXTOnPlayerJoinDefault(s_machine_slot* mS, e_color_team_index cur_team) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerJoinDefault < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerJoinDefault++;
        index = to!wstring(checkHooks.EXTOnPlayerJoinDefault) ~ "\0";
        VARIANTshort(&vars[0], mS.machineIndex);
        VARIANTstr(&vars[1], mS.SessionKey.ptr);
        VARIANTint(&vars[2], mS.isAvailable);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "mIndex: {0:hd}, SessionKey: {1:s}, isAvailable: {2:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[4].ptr, index.ptr, output.ptr);
    }
    return e_color_team_index.NONE; //If set to 0 will force set to red team. Or set to 1 will force set to blue team. -1 is default team.
}

deprecated("Do not use EXTOnNewGame hook, use EXTOnMapLoad hook instead.")
export extern(C) void EXTOnNewGame(wchar* map) {
    VARIANT[1] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnNewGame < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnNewGame++;
        index = to!wstring(checkHooks.EXTOnNewGame) ~ "\0";
        VARIANTwstr(&vars[0], map);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Map: {0:s}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[5].ptr, index.ptr, output.ptr);
    }
}

export extern(C) void EXTOnEndGame(int mode) {
    VARIANT[1] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnEndGame < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnEndGame++;
        index = to!wstring(checkHooks.EXTOnEndGame) ~ "\0";
        VARIANTint(&vars[0], mode);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Mode: {0:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[6].ptr, index.ptr, output.ptr);
    }

}

export extern(C) bool EXTOnObjectInteraction(PlayerInfo plI, s_ident obj_id, s_object* objectStruct, hTagHeader* hTag) {
    VARIANT[5] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnObjectInteraction < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnObjectInteraction++;
        index = to!wstring(checkHooks.EXTOnObjectInteraction) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTint(&vars[1], obj_id.Tag);
        VARIANTint(&vars[2], objectStruct.ModelTag.Tag);
        VARIANTshort(&vars[3], objectStruct.GameObject);
        VARIANTstr(&vars[4], hTag.tag_name);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, ObjectID: {1:08X}, ModelTag: {2:08X}, GameObject: {3:hd}, tagName: {4:s}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[7].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it will deny interaction to an object.
}

export extern(C) void EXTOnWeaponAssignmentDefault(PlayerInfo plI, s_ident owner_obj_id, s_tag_reference* cur_weap_id, uint order, s_ident* new_weap_id) {
    VARIANT[5] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnWeaponAssignmentDefault < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnWeaponAssignmentDefault++;
        index = to!wstring(checkHooks.EXTOnWeaponAssignmentDefault) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTint(&vars[1], owner_obj_id.Tag);
        VARIANTstr(&vars[2], cur_weap_id.name);
        VARIANTint(&vars[3], order);
        VARIANTint(&vars[4], new_weap_id.Tag);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, OwnerObjectID: {1:08X}, Weapon Name: {2:s}, Order: {3:d}, newWeapID: {4:08X}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[8].ptr, index.ptr, output.ptr);
    }
}

export extern(C) void EXTOnWeaponAssignmentCustom(PlayerInfo plI, s_ident owner_obj_id, s_ident cur_weap_id, uint order, s_ident* new_weap_id) {
    VARIANT[5] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnWeaponAssignmentCustom < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnWeaponAssignmentCustom++;
        index = to!wstring(checkHooks.EXTOnWeaponAssignmentCustom) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTint(&vars[1], owner_obj_id.Tag);
        VARIANTint(&vars[2], cur_weap_id.Tag);
        VARIANTint(&vars[3], order);
        VARIANTint(&vars[4], new_weap_id.Tag);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, OwnerObjectID: {1:08X}, curWeaponID: {2:08X}, Order: {3:d}, newWeapID: {4:08X}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[9].ptr, index.ptr, output.ptr);
    }
}

export extern(C) void EXTOnServerIdle() {
    wstring index;
    if (checkHooks.EXTOnServerIdle < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnServerIdle++;
        index = to!wstring(checkHooks.EXTOnServerIdle) ~ "\0";
        pICIniFile.m_value_set(pICIniFile, HookNames[10].ptr, index.ptr, "Idle"w.ptr);
    }
}

export extern(C) bool EXTOnPlayerScoreCTF(PlayerInfo plI, s_ident cur_weap_id, uint team, bool isGameObject) {
    VARIANT[4] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerScoreCTF < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerScoreCTF++;
        index = to!wstring(checkHooks.EXTOnPlayerScoreCTF) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTint(&vars[1], cur_weap_id.Tag);
        VARIANTint(&vars[2], team);
        VARIANTint(&vars[3], isGameObject);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, curWeaponID: {1:08X}, Team: {2:d}, isGameObject: {3:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[11].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it will prevent player to score a flag.
}

export extern(C) bool EXTOnWeaponDropAttemptMustBeReadied(PlayerInfo plI, s_ident owner_obj_id, s_biped* pl_Biped) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnWeaponDropAttemptMustBeReadied < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnWeaponDropAttemptMustBeReadied++;
        index = to!wstring(checkHooks.EXTOnWeaponDropAttemptMustBeReadied) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTint(&vars[1], owner_obj_id.Tag);
        VARIANTint(&vars[2], pl_Biped.sObject.ModelTag.Tag);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, ownerObjID: {1:08X}, pl_Biped: {2:08X}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[12].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it will prevent player to drop an object.

}

export extern(C) void EXTOnPlayerSpawn(PlayerInfo plI, s_ident obj_id, s_biped* pl_Biped) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerSpawn < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerSpawn++;
        index = to!wstring(checkHooks.EXTOnPlayerSpawn) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTint(&vars[1], obj_id.Tag);
        VARIANTuint(&vars[2], cast(uint)pl_Biped);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, obj_id: {1:08X}, pl_Biped: {2:08X}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[13].ptr, index.ptr, output.ptr);
    }
}

export extern(C) bool EXTOnPlayerVehicleEntry(PlayerInfo plI, bool forceEntry) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerVehicleEntry < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerVehicleEntry++;
        index = to!wstring(checkHooks.EXTOnPlayerVehicleEntry) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTbool(&vars[1], forceEntry);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, forceEntry: {1:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[14].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it will prevent player enter a vehicle.
}

export extern(C) bool EXTOnPlayerVehicleEject(PlayerInfo plI, bool forceEject) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerVehicleEject < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerVehicleEject++;
        index = to!wstring(checkHooks.EXTOnPlayerVehicleEject) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTbool(&vars[1], forceEject);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, forceEject: {1:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[15].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it will prevent player leave a vehicle.
}

export extern(C) bool EXTOnPlayerSpawnColor(PlayerInfo plI, bool isTeamPlay) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerSpawnColor < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerSpawnColor++;
        index = to!wstring(checkHooks.EXTOnPlayerSpawnColor) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        VARIANTshort(&vars[1], plI.plR.ColorIndex);
        VARIANTbool(&vars[2], isTeamPlay);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, Color Index: {1:hd}, isTeamPlay: {2:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[16].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it will use custom color instead of team color.
}

export extern(C) PLAYER_VALIDATE EXTOnPlayerValidateConnect(PlayerExtended plEx, s_machine_slot mS, s_ban_check banCheckPlayer, bool isBanned, toggle svPass, PLAYER_VALIDATE isForceReject) {
    VARIANT[6] vars;
    wchar[INIFILEVALUEMAX] output;
    char[33] banCheckPlayerHashA;
    wchar[8] index;
    int indexLength;
    if (checkHooks.EXTOnPlayerValidateConnect < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerValidateConnect++;
        index[0] = 0;
        banCheckPlayerHashA[0] = 0;
        indexLength = pIUtil.m_strcatA(banCheckPlayerHashA.ptr, 32, banCheckPlayer.cdKeyHash.ptr);
        banCheckPlayerHashA[indexLength] = 0;

        indexLength = pIUtil.m_strcatW(index.ptr, 8, (to!wstring(checkHooks.EXTOnPlayerValidateConnect) ~ "\0").ptr);
        VARIANTwstr(&vars[0], plEx.CDHashW.ptr);
        VARIANTstr(&vars[1], banCheckPlayerHashA.ptr);
        VARIANTwstr(&vars[2], banCheckPlayer.requestPlayerName.ptr);
        VARIANTbool(&vars[3], isBanned);
        VARIANTchar(&vars[4], svPass);
        VARIANTint(&vars[5], isForceReject);
        index[indexLength] = '.';
        indexLength++;
        index[indexLength] = '1';
        index[indexLength + 1] = 0;
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "plEx.CDHashW: {0:s}, banCheckPlayer.cdKeyHash: {1:s}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[17].ptr, index.ptr, output.ptr);
        index[indexLength] = '2';
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Request Name: {2:s}, isBanned: {3:d}, svPass: {4:hhd} isForceReject: {5:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[17].ptr, index.ptr, output.ptr);
    }
    return PLAYER_VALIDATE.DEFAULT; //Look in PLAYER_VALIDATE enum for available options to return.
}

export extern(C) bool EXTOnWeaponReload(s_object* obj_Struct, bool allowReload) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnWeaponReload < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnWeaponReload++;
        index = to!wstring(checkHooks.EXTOnWeaponReload) ~ "\0";
        VARIANTint(&vars[0], obj_Struct.ModelTag.Tag);
        VARIANTint(&vars[1], allowReload);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Object Model Tag: {0:08X}, allowReload: {1:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[18].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, weapon will not reload. Unless allowReload is false, then this value is ignored.
}

// Enabled in 0.5.3.4
export extern(C) void EXTOnObjectCreate(s_ident obj_id, s_object* obj_Struct, hTagHeader* header) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnObjectCreate < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnObjectCreate++;
        index = to!wstring(checkHooks.EXTOnObjectCreate) ~ "\0";
        VARIANTint(&vars[0], obj_Struct.ModelTag.Tag);
        VARIANTstr(&vars[1], header.tag_name);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Object Model Tag: {0:08X}, tag_name: {1:s}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[19].ptr, index.ptr, output.ptr);
    }
}

export extern(C) void EXTOnKillMultiplier(PlayerInfo killer, uint multiplier) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnKillMultiplier < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnKillMultiplier++;
        index = to!wstring(checkHooks.EXTOnKillMultiplier) ~ "\0";
        VARIANTwstr(&vars[0], killer.plS.Name.ptr);
        VARIANTint(&vars[1], multiplier);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, Multiplier: {1:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[20].ptr, index.ptr, output.ptr);
    }
}

// Enabled in 0.5.3.4
export extern(C) VEHICLE_RESPAWN EXTOnVehicleRespawnProcess(s_ident obj_id, s_object* cur_object, objManaged* managedObj, bool isManaged) {
    VARIANT[5] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnVehicleRespawnProcess < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnVehicleRespawnProcess++;
        index = to!wstring(checkHooks.EXTOnVehicleRespawnProcess) ~ "\0";
        VARIANTint(&vars[0], cur_object.ModelTag.Tag);
        VARIANTfloat(&vars[1], managedObj.world.x);
        VARIANTfloat(&vars[2], managedObj.world.y);
        VARIANTfloat(&vars[3], managedObj.world.z);
        VARIANTbool(&vars[4], isManaged);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "ModelTag: {0:08X}, World X: {1:f}, Y: {2:f}, Z: {3:f}, isManaged: {4:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[21].ptr, index.ptr, output.ptr);
    }
    return VEHICLE_RESPAWN.DEFAULT; //Look in VEHICLE_RESPAWN enum for available options to return.
}

// Enabled in 0.5.3.4
export extern(C) OBJECT_ATTEMPT EXTOnObjectDeleteAttempt(s_ident obj_id, s_object* cur_object, int curTicks) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnObjectDeleteAttempt < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnObjectDeleteAttempt++;
        index = to!wstring(checkHooks.EXTOnObjectDeleteAttempt) ~ "\0";
        VARIANTint(&vars[0], cur_object.ModelTag.Tag);
        VARIANTint(&vars[1], curTicks);
        VARIANTbool(&vars[2], isManaged);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "ModelTag: {0:08X}, Current Ticks: {1:d}, isManaged: {2:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[22].ptr, index.ptr, output.ptr);
    }
    return OBJECT_ATTEMPT.DEFAULT; //Look in OBJECT_ATTEMPT enum for available options to return.
}

export extern(C) bool EXTOnObjectDamageLookupProcess(objDamageInfo* damageInfo, s_ident* obj_recv, bool* allowDamage, bool isManaged) {
    VARIANT[5] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnObjectDamageLookupProcess < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnObjectDamageLookupProcess++;
        index = to!wstring(checkHooks.EXTOnObjectDamageLookupProcess) ~ "\0";
        VARIANTint(&vars[0], damageInfo.causer.Tag);
        VARIANTint(&vars[1], damageInfo.player_causer.Tag);
        VARIANTint(&vars[2], obj_recv ? obj_recv.Tag : 0);
        VARIANTbool(&vars[3], *allowDamage);
        VARIANTbool(&vars[4], isManaged);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Causer: {0:08X}, PlayerCauser: {1:08X}, obj_recv: {2:08X}, allowDamage: {3:d}, isManaged: {4:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[23].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it is managed by you. True for default.

}

export extern(C) bool EXTOnObjectDamageApplyProcess(const objDamageInfo* damageInfo, s_ident* obj_recv, objHitInfo* hitInfo, bool isBacktap, bool* allowDamage, bool isManaged) {
    VARIANT[6] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnObjectDamageApplyProcess < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnObjectDamageApplyProcess++;
        index = to!wstring(checkHooks.EXTOnObjectDamageApplyProcess) ~ "\0";
        VARIANTint(&vars[0], damageInfo.causer.Tag);
        VARIANTint(&vars[1], damageInfo.player_causer.Tag);
        VARIANTint(&vars[2], obj_recv ? obj_recv.Tag : 0);
        VARIANTbool(&vars[3], isBacktap);
        VARIANTbool(&vars[4], *allowDamage);
        VARIANTbool(&vars[5], isManaged);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Causer: {0:08X}, PlayerCauser: {1:08X}, obj_recv: {2:08X}, isBacktap: {3:d}, allowDamage: {4:d}, isManaged: {5:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[24].ptr, index.ptr, output.ptr);
    }
    return 1; //If set to false, it is managed by you. True for default.
}

// Featured in 0.5.1 and newer
// Changed in 0.5.3.3
export extern(C) void EXTOnMapLoad(s_ident map_tag, const wchar* map_name, GAME_MODE game_mode) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnMapLoad < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnMapLoad++;
        index = to!wstring(checkHooks.EXTOnMapLoad) ~ "\0";
        VARIANTint(&vars[0], map_tag.Tag);
        VARIANTwstr(&vars[1], map_name);
        VARIANTshort(&vars[2], game_mode);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Map Tag: {0:08X}, Map: {1:s}, Game Mode: {2:hd}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[25].ptr, index.ptr, output.ptr);
    }
}

export extern(C) toggle EXTOnAIVehicleEntry(s_ident bipedTag, s_ident vehicleTag, ushort seatNum, toggle isManaged) {
    VARIANT[4] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnAIVehicleEntry < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnAIVehicleEntry++;
        index = to!wstring(checkHooks.EXTOnAIVehicleEntry) ~ "\0";
        VARIANTint(&vars[0], bipedTag.Tag);
        VARIANTint(&vars[1], vehicleTag.Tag);
        VARIANTushort(&vars[2], seatNum);
        VARIANTchar(&vars[3], isManaged);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "bipedTag: {0:08X}, vehicleTag: {1:08X}, seatNum: {2:hd}, isManaged: {3:hhd}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[26].ptr, index.ptr, output.ptr);
    }
    return -1; //-1 = default, 0 = prevent entry, 1 = force entry
}

// Changed in 0.5.3.3
export extern(C) void EXTOnWeaponDropCurrent(PlayerInfo plI, s_ident bipedTag, s_biped* biped, s_ident weaponTag, s_weapon* weapon) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnWeaponDropCurrent < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnWeaponDropCurrent++;
        index = to!wstring(checkHooks.EXTOnWeaponDropCurrent) ~ "\0";
        VARIANTint(&vars[0], bipedTag.Tag);
        VARIANTint(&vars[1], weaponTag.Tag);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "bipedTag: {0:08X}, weaponTag: {1:08X}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[27].ptr, index.ptr, output.ptr);
    }
}

export extern(C) toggle EXTOnServerStatus(int execId, toggle isManaged) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnServerStatus < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnServerStatus++;
        index = to!wstring(checkHooks.EXTOnServerStatus) ~ "\0";
        VARIANTint(&vars[0], execId);
        VARIANTchar(&vars[1], isManaged);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "execId: {0:d}, isManaged: {1:hhd}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[28].ptr, index.ptr, output.ptr);
    }
    return -1; //-1 = default, 0 = hide message, 1 = show message
}

// Featured in 0.5.2.3 and newer
export extern(C) void EXTOnPlayerUpdate(PlayerInfo plI) {
    VARIANT[1] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnPlayerUpdate < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnPlayerUpdate++;
        index = to!wstring(checkHooks.EXTOnPlayerUpdate) ~ "\0";
        VARIANTwstr(&vars[0], plI.plS.Name.ptr);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[29].ptr, index.ptr, output.ptr);
    }
}

export extern(C) void EXTOnMapReset() {
    wstring index;
    if (checkHooks.EXTOnMapReset < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnMapReset++;
        index = to!wstring(checkHooks.EXTOnMapReset) ~ "\0";
        pICIniFile.m_value_set(pICIniFile, HookNames[30].ptr, index.ptr, "Reset"w.ptr);
    }
}

// Featured in 0.5.3.0 and newer
// Enabled in 0.5.3.4
export extern(C) OBJECT_ATTEMPT EXTOnObjectCreateAttempt(PlayerInfo plOwner, objCreationInfo object_creation, objCreationInfo* change_object, bool isOverride) {
    VARIANT[6] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnObjectCreateAttempt < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnObjectCreateAttempt++;
        index = to!wstring(checkHooks.EXTOnObjectCreateAttempt) ~ "\0";
        VARIANTint(&vars[0], object_creation.map_id.Tag);
        VARIANTint(&vars[1], object_creation.parent_id.Tag);
        VARIANTfloat(&vars[2], object_creation.pos.x);
        VARIANTfloat(&vars[3], object_creation.pos.y);
        VARIANTfloat(&vars[4], object_creation.pos.z);
        VARIANTbool(&vars[5], isOverride);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "map_id: {0:08X}, parent_id: {1:08X}, pos.x: {2:f}, pos.y: {3:f}, pos.z: {4:f}, isOverride: {5:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[31].ptr, index.ptr, output.ptr);
    }
    return OBJECT_ATTEMPT.DEFAULT; //Look in OBJECT_ATTEMPT enum for available options to return.
}

//Featured in 0.5.3.2 and newer
export extern(C) bool EXTOnGameSpyValidationCheck(uint UniqueID, bool isValid, bool forceBypass) {
    VARIANT[3] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnGameSpyValidationCheck < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnGameSpyValidationCheck++;
        index = to!wstring(checkHooks.EXTOnGameSpyValidationCheck) ~ "\0";
        VARIANTint(&vars[0], UniqueID);
        VARIANTbool(&vars[1], isValid);
        VARIANTbool(&vars[2], forceBypass);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "UniqueID: {0:d}, isValid: {1:d}, forceBypass: {2:d}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[32].ptr, index.ptr, output.ptr);
    }
    return 1; //Set to false will force bypass. True for default. Use isOverride check.
}

//Featured in 0.5.3.3 and newer
export extern(C) bool EXTOnWeaponExchangeAttempt(PlayerInfo plOwner, s_ident bipedTag, s_biped* biped, int slot_index, s_ident weaponTag, s_weapon* weapon, bool allowExchange) {
    VARIANT[5] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnWeaponExchangeAttempt < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnWeaponExchangeAttempt++;
        index = to!wstring(checkHooks.EXTOnWeaponExchangeAttempt) ~ "\0";
        VARIANTwstr(&vars[0], plOwner.plS==null ? nullStr.ptr : plOwner.plS.Name.ptr);
        VARIANTint(&vars[1], bipedTag.Tag);
        VARIANTint(&vars[2], slot_index);
        VARIANTint(&vars[3], weaponTag.Tag);
        VARIANTbool(&vars[4], allowExchange);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Player: {0:s}, bipedTag: {1:08X}, index: {2:d}, weaponTag: {3:08X}, allowExchange: {4:hhd}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[33].ptr, index.ptr, output.ptr);
    }
    return 1; //If false, then will deny exchange weapon. True by default. Use allowExchange check, if already false. Don't do anything.
}

export extern(C) void EXTOnObjectDelete(s_ident obj_id, s_object* obj_Struct, hTagHeader* header) {
    VARIANT[2] vars;
    wchar[INIFILEVALUEMAX] output;
    wstring index;
    if (checkHooks.EXTOnObjectDelete < MAX_HOOK_COUNTER) {
        checkHooks.EXTOnObjectDelete++;
        index = to!wstring(checkHooks.EXTOnObjectDelete) ~ "\0";
        VARIANTint(&vars[0], obj_Struct.ModelTag.Tag);
        VARIANTstr(&vars[1], header.tag_name);
        pIUtil.m_formatVariantW(output.ptr, INIFILEVALUEMAX, "Object Model Tag: {0:08X}, tag_name: {1:s}"w.ptr, vars.length, vars.ptr);
        pICIniFile.m_value_set(pICIniFile, HookNames[34].ptr, index.ptr, output.ptr);
    }
}
